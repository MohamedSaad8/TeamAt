import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/servcies/firestore_user.dart';
import 'package:team_at/view/home_view.dart';

class AuthViewModel extends GetxController
{
  String email ;
  String password ;
  String phone ;
  String name  ;
  String userName ;
  String profileImageUrl ;
  String longitude ;
  String latitude ;
  String verificationCode ;

  FirebaseAuth _auth = FirebaseAuth.instance;

  signInWithEmailAndPassword() async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(HomeView(),
          curve: Curves.easeInBack);

    }catch(e)
    {
      Get.snackbar("Login Error", e.message , snackPosition :SnackPosition.BOTTOM ,
          duration: Duration(seconds: 5)
      ) ;
    }
  }

  createAccountWithEmailAndPassword ()async {
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user) async  {
        saveUserData(user);
      });

      Get.offAll(HomeView());
    }catch(e)
    {
      Get.snackbar("Register Error", e.message, snackPosition :SnackPosition.BOTTOM ,
          duration: Duration(seconds: 5));
    }
  }

  void saveUserData(UserCredential user) async {
    await FireStoreUser().addUserToFireStore(UserModel(
      userName: userName ,
      userID: user.user.uid,
      email: user.user.email,
      latitude: latitude,
      longitude: longitude,
      name: name,
      phone: phone,
      picURL: profileImageUrl,
    ));
  }

  verifyPhoneNumber () async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted:(auth)  {
           Get.to(HomeView());
        },
        verificationFailed: (FirebaseAuthException e){
         Get.snackbar("Verification Error ", e.message) ;
          print(e.message);
        },
        codeSent: (verificationID , recentToken){
            verificationCode = verificationID ;
            update();
        },
        codeAutoRetrievalTimeout: (verificationID){

            verificationCode = verificationID ;
            update();
        },
        timeout: Duration(seconds: 120)
    );
  }




}