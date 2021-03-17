import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/model/post_model.dart';
import 'package:team_at/servcies/firestore_comments.dart';
import 'package:team_at/servcies/firestore_post.dart';
import 'package:team_at/servcies/getImage.dart';
import 'package:team_at/model/comment_model.dart';

class PostsViewModel extends GetxController
{
  String postContent ;
  String postImageURL ;
  String postId;
  String groupId ;
  String userId ;
  String commentContent ;
  File postImage ;
  bool isLoading = false ;
 // List<dynamic> likes ;
  List<CommentModel> postComments  = [] ;
  List<PostModel> groupPosts = [];
  List<PostModel> userPosts = [];
  List<PostModel> followingGroupsPosts = [] ;
  List<UserModel> allUsers = [] ;
  List<GroupModel> allGroups = [];
  int myGroups = 0;
 int followingGroups = 0;





  @override
  void onInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userID = preferences.getString("userID");
    print("user id is $userID");
    await getUserFromFireStore(userID);
    await getAllUser();
    await getAllGroups();
    await getAllPostsByUserId();
    await getAllFollowingGroupsPostsByUserId();
    super.onInit();
  }

  setImageEqualNull() {
    postImage = null ;
    postImageURL = "" ;
    update();

  }

  changeIsLoading(bool newValue){
    isLoading = newValue ;
    update();
  }

  getUserFromFireStore(String userID) async{
    await FirebaseFirestore.instance.collection("Users").doc(userID).get().then((value){
      UserModel.currentUser = UserModel.fromJson(value.data());
    });
    //
    update();
  }

  Future<void> createPost(PostModel post , String groupId)async {
    await FireStorePosts().postCollectionRef.doc(post.postId).set(post.toJson());
    getGroupPostsFromFireStore(groupId);
  }

  getPostImageFromGallery()async {
    postImage = File(await getImageFromGallery()) ;
    update();
  }

  getPostImageFromGCamera()async {
    postImage = File(await getImageFromCamera()) ;
    update();
  }

  Future<void> uploadImage() async {
    try {
      FirebaseStorage firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://teamat-47704.appspot.com');
      StorageReference storageReference =
      firebaseStorage.ref().child(p.basename(postImage.path));
      StorageUploadTask storageUploadTask = storageReference.putFile(postImage);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
      postImageURL = await snapshot.ref.getDownloadURL();
      update();
      print("uploaded done");

    } catch (ex) {
      print(ex.message);
    }
  }

  addLike(PostModel post)async{
    List<dynamic> likesList = post.likes;
    likesList.add(UserModel.currentUser.userID);
    PostModel newPost = PostModel(
      postId: post.postId,
      userId: post.userId,
      postImageURL: post.postImageURL,
      postContent: post.postContent,
      groupId: post.groupId,
      likes: likesList,
      comments: post.comments
    );
    await FireStorePosts().postCollectionRef.doc(post.postId).update(newPost.toJson());
     getGroupPostsFromFireStore(post.groupId);

  }

  removeLike(PostModel post)async{
    List<dynamic> likesList = post.likes;
    likesList.remove(UserModel.currentUser.userID);
    PostModel newPost = PostModel(
        postId: post.postId,
        userId: post.userId,
        postImageURL: post.postImageURL,
        postContent: post.postContent,
        groupId: post.groupId,
        likes: likesList,
      comments: post.comments
    );
    await FireStorePosts().postCollectionRef.doc(post.postId).update(newPost.toJson());
    await getGroupPostsFromFireStore(post.groupId);
  }

  getGroupPostsFromFireStore(String groupId)async{
    groupPosts.clear();
    try{
      var snapShot = await FireStorePosts().postCollectionRef.get();
      for (var doc in snapShot.docs) {
        var data = doc.data();
        if (data["groupId"] == groupId) {
          groupPosts.add(PostModel.fromJson(data));
        }
      }
    }catch(e){
      groupPosts = [];
    }
    update();

  }

  getPostCommentsFromFireStore(String postId) async {
    postComments.clear();
    try{
      var snapShot = await FireStoreComments().commentCollectionRef.get();
      for (var doc in snapShot.docs) {
        var data = doc.data();
        if (data["postId"] == postId) {
          postComments.add(CommentModel.fromJson(data));
        }
      }
    }catch(e){
      postComments = [];
    }

    update();
  }

  getAllPostsByUserId() async{
    userPosts.clear();
    try{
      var snapShot = await FireStorePosts().postCollectionRef.get();
      for (var doc in snapShot.docs) {
        var data = doc.data();
        if (data["userId"] == UserModel.currentUser.userID) {
          userPosts.add(PostModel.fromJson(data));
        }
      }
    }catch(e){
      userPosts = [];
    }
    update();

  }

  getAllFollowingGroupsPostsByUserId() async{
    followingGroupsPosts.clear();
    try{
      var snapShot = await FireStorePosts().postCollectionRef.get();
      for (var doc in snapShot.docs) {
        var data = doc.data();
        if (getGroup(data["groupId"]).confirmedUsers.contains(UserModel.currentUser.userID)) {
          followingGroupsPosts.add(PostModel.fromJson(data));
        }
      }
    }catch(e){
      followingGroupsPosts = [];
    }
    update();

  }

  getAllUser() async  {
    await FirebaseFirestore.instance.collection("Users").get().then((value){
      for(var doc in value.docs){
        allUsers.add(UserModel.fromJson(doc.data()));
      }
    });
    update();
  }

  getAllGroups() async  {
    await FirebaseFirestore.instance.collection("Groups").get().then((value){
      for(var doc in value.docs){
        allGroups.add(GroupModel.fromJson(doc.data()));
      }
    });
    for(GroupModel group in allGroups)
      {
        if(group.admin == UserModel.currentUser.userID)
        {
          myGroups++;
        }
        else
          {
            followingGroups++;
          }
      }
    update();
  }

  GroupModel getGroup (String groupId) {
    GroupModel groupData ;
    for(var group in allGroups){
      if(group.groupID == groupId)
        groupData = group;
    }
    return groupData ;
  }

  UserModel getUser (String userId) {
    UserModel userData ;
    for(var user in allUsers){
      if(user.userID == userId)
        userData = user;
    }
    return userData ;
  }

  createComment({CommentModel comment, PostModel post, String groupId}) async{
    await FireStoreComments().commentCollectionRef.doc(comment.commentId).set(comment.toJson());
    List<dynamic> commentList = post.comments;
    commentList.add(comment.commentId);
    PostModel newPost = PostModel(
        postId: post.postId,
        userId: post.userId,
        postImageURL: post.postImageURL,
        postContent: post.postContent,
        groupId: post.groupId,
        likes: post.likes,
        comments: commentList
    );
    await FireStorePosts().postCollectionRef.doc(post.postId).update(newPost.toJson());
    await getPostCommentsFromFireStore(post.postId);
    await getAllPostsByUserId();


  }





}