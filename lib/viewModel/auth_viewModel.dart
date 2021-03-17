import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/servcies/firestore_user.dart';
import 'package:team_at/servcies/getImage.dart';
import 'package:team_at/view/controll_view.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class AuthViewModel extends GetxController {
  String email;
  String password;
  String phone;
  String name;
  String userName;
  String profileImageUrl;
  double longitude;
  double latitude;
  File profileImage;
  String country ;
  bool isLoading = false ;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rx<User> _user = Rx<User> () ;
  String get userEmail => _user.value?.email ;


  @override
  void onInit() {
    _user.bindStream(_auth.authStateChanges());
    super.onInit() ;
  }

  ///-----------------------------------------------------------------------------



  signInWithEmailAndPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance() ;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((user){
        preferences.setString("userID", user.user.uid);
      }
   );
    } catch (e) {
      Get.snackbar("Login Error", e.message,
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 5));
    }
  }
  signOut()async{
    await _auth.signOut();
  }

  changeIsLoading(bool newValue) {
    isLoading = newValue ;
    update();
  }

 void createAccountWithEmailAndPassword() async {
   SharedPreferences preferences = await SharedPreferences.getInstance() ;
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        preferences.setString("userID", user.user.uid);
        saveUserData(user);
      });

      Get.offAll(ControlView());
    } catch (e) {
      Get.snackbar("Register Error", e.message,
          snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 5));
    }
  }

  void saveUserData(UserCredential user) async {
    await FireStoreUser().addUserToFireStore(UserModel(
      userName: userName,
      userID: user.user.uid,
      email: user.user.email,
      latitude: latitude,
      longitude: longitude,
      name: name,
      phone: phone,
      picURL: profileImageUrl,
      country: country,

    ),
    );
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
          profileImage = File(await getImageFromGallery()) ;
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
          profileImage = File(await getImageFromCamera()) ;
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
      firebaseStorage.ref().child(p.basename(profileImage.path));
      StorageUploadTask storageUploadTask = storageReference.putFile(profileImage);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
      profileImageUrl = await snapshot.ref.getDownloadURL();
      update();
      print("uploaded done");

    } catch (ex) {
      print(ex.message);
    }
  }

  getUserLocation()async{
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude ;
    longitude = position.longitude ;
    var address = await Geocoder.local.findAddressesFromCoordinates(Coordinates(latitude , longitude));
    country = address.first.countryName;
    update();
  }
}
