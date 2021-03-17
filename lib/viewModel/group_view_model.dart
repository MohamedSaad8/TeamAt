import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/servcies/firestore_groups.dart';
import 'package:team_at/servcies/getImage.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:path/path.dart' as p;

class GroupViewModel extends GetxController {
  String groupName ;
  String groupDescription ;
  double groupLongitude ;
  double groupLatitude ;
  File groupImage ;
  String groupImageURL;
  String groupID ;
  bool isLoading = false ;
  List<GroupModel> myGroupsList = [];
  List<GroupModel> otherGroups = [];
  List<UserModel> allUsers = [] ;




  @override
  void onInit() async {
    await getGroups();
    await getAllUser();
    super.onInit();
  }



  changeIsLoading(bool newValue){
    isLoading = newValue ;
    update();
  }

  setImageEqualNull()
  {
    groupImage = null ;
    update();

  }

  getGroups() async {
    myGroupsList.clear();
    otherGroups.clear();
    try {
      var snapShot = await FireStoreGroups().groupCollectionRef.get();
      for (var doc in snapShot.docs) {
        var data = doc.data();
        if (data["confirmedUsers"].contains(UserModel.currentUser.userID)) {
          try{
            myGroupsList.add(GroupModel.fromJson(data));
          }
          catch(e){print(e);}
          print("done");

        } else {
          otherGroups.add(GroupModel.fromJson(data));
        }
      }
    } catch (e) {
      myGroupsList = [];
      otherGroups = [];
    }
    update();
  }

  Future<void> addGroupToFireStore(GroupModel groupModel) async {
    await FireStoreGroups().groupCollectionRef.doc(groupModel.groupID).set(groupModel.toJson());
    await getGroups();
  }

  showDialogForChoseImages(context) {
    Get.defaultDialog(
      title: "selectImage".tr,
      middleText: "chooseAway".tr,
      middleTextStyle: TextStyle(
          fontSize: 16.sp
      ),
      titleStyle: TextStyle(fontSize: 20.sp),
      cancel: GestureDetector(
        onTap: () async{
          groupImage = File(await getImageFromGallery()) ;
          Navigator.pop(context);
          update();

        },
        child: Container(
          padding: EdgeInsets.all(10),
          color: kSecondColor,
          child: CustomText(
            text: "FromGallery".tr,
            fontColor: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
      confirm: GestureDetector(
        onTap: ()async{
          groupImage = File(await getImageFromCamera()) ;
          Navigator.pop(context);
          update();
        },
        child: Container(
          padding: EdgeInsets.all(10),
          color: kSecondColor,
          child: CustomText(
            text: "fromCamera".tr,
            fontColor: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    try {
      FirebaseStorage firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://teamat-47704.appspot.com');
      StorageReference storageReference =
      firebaseStorage.ref().child(p.basename(groupImage.path));
      StorageUploadTask storageUploadTask = storageReference.putFile(groupImage);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
      groupImageURL = await snapshot.ref.getDownloadURL();
      update();
      print("uploaded done");

    } catch (ex) {
      print(ex.message);
    }
  }

  getGroupLocationLocation()async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    groupLatitude = position.latitude ;
    groupLongitude = position.longitude ;
    var address = await Geocoder.local.findAddressesFromCoordinates(Coordinates(groupLatitude , groupLongitude));
    update();
  }

  joinToGroup(GroupModel groupModel)async{
    List<dynamic> requestList = groupModel.unConfirmedUsers;
    requestList.add(UserModel.currentUser.userID);
    print(requestList.length);
    GroupModel newGroup = GroupModel(
      groupID: groupModel.groupID ,
      groupPictureURL: groupModel.groupPictureURL,
      groupName: groupModel.groupName,
      groupLongitude: groupModel.groupLongitude,
      groupLatitude: groupModel.groupLatitude,
      groupDescription: groupModel.groupDescription,
      confirmedUsers: groupModel.confirmedUsers,
      admin: groupModel.admin,
      unConfirmedUsers: requestList
    );

    await FireStoreGroups().groupCollectionRef.doc(groupModel.groupID).update(newGroup.toJson());
    await getGroups();
  }

  cancelRequest(GroupModel groupModel)async{
    List<dynamic> requestList = groupModel.unConfirmedUsers;
    requestList.remove(UserModel.currentUser.userID);
    print(requestList.length);
    GroupModel newGroup = GroupModel(
        groupID: groupModel.groupID ,
        groupPictureURL: groupModel.groupPictureURL,
        groupName: groupModel.groupName,
        groupLongitude: groupModel.groupLongitude,
        groupLatitude: groupModel.groupLatitude,
        groupDescription: groupModel.groupDescription,
        confirmedUsers: groupModel.confirmedUsers,
        admin: groupModel.admin,
        unConfirmedUsers: requestList
    );

    await FireStoreGroups().groupCollectionRef.doc(groupModel.groupID).update(newGroup.toJson());
    await getGroups();
  }

  acceptRequest(GroupModel groupModel , String userID)async{
    List<dynamic> requestList = groupModel.unConfirmedUsers;
    List<dynamic> acceptList = groupModel.confirmedUsers ;
    requestList.remove(userID);
    print(requestList.length);
    acceptList.add(userID);
    GroupModel newGroup = GroupModel(
        groupID: groupModel.groupID ,
        groupPictureURL: groupModel.groupPictureURL,
        groupName: groupModel.groupName,
        groupLongitude: groupModel.groupLongitude,
        groupLatitude: groupModel.groupLatitude,
        groupDescription: groupModel.groupDescription,
        confirmedUsers: acceptList,
        admin: groupModel.admin,
        unConfirmedUsers: requestList
    );

    await FireStoreGroups().groupCollectionRef.doc(groupModel.groupID).update(newGroup.toJson());
    await getGroups();
  }

  refuseRequest(GroupModel groupModel, String userID)async{
    List<dynamic> requestList = groupModel.unConfirmedUsers;
    requestList.remove(userID);
    print(requestList.length);
    GroupModel newGroup = GroupModel(
        groupID: groupModel.groupID ,
        groupPictureURL: groupModel.groupPictureURL,
        groupName: groupModel.groupName,
        groupLongitude: groupModel.groupLongitude,
        groupLatitude: groupModel.groupLatitude,
        groupDescription: groupModel.groupDescription,
        confirmedUsers: groupModel.confirmedUsers,
        admin: groupModel.admin,
        unConfirmedUsers: requestList
    );

    await FireStoreGroups().groupCollectionRef.doc(groupModel.groupID).update(newGroup.toJson());
    await getGroups();
  }

  leaveGroup(GroupModel groupModel)async{
    List<dynamic> requestList = groupModel.confirmedUsers;
    requestList.remove(UserModel.currentUser.userID);
    print(requestList.length);
    GroupModel newGroup = GroupModel(
        groupID: groupModel.groupID ,
        groupPictureURL: groupModel.groupPictureURL,
        groupName: groupModel.groupName,
        groupLongitude: groupModel.groupLongitude,
        groupLatitude: groupModel.groupLatitude,
        groupDescription: groupModel.groupDescription,
        confirmedUsers: groupModel.confirmedUsers,
        admin: groupModel.admin,
        unConfirmedUsers: requestList
    );

    await FireStoreGroups().groupCollectionRef.doc(groupModel.groupID).update(newGroup.toJson());
    await getGroups();
  }

  getAllUser() async  {
    await FirebaseFirestore.instance.collection("Users").get().then((value){
       for(var doc in value.docs){
         allUsers.add(UserModel.fromJson(doc.data()));
       }
    });
    update();
  }

UserModel getUser (String userId) {
    UserModel userData ;
    for(var user in allUsers){
      if(user.userID == userId)
        userData = user;
    }
    return userData ;
}


}
