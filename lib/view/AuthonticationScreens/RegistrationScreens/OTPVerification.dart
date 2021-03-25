import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/helper/local_storage_helper/language_local_storage.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import '../../home_view.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/complete_info_view.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OTPVerification extends StatefulWidget {
  String phoneNumber;

  String countryCode;


  OTPVerification({@required this.phoneNumber, this.countryCode});

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}


class _OTPVerificationState extends State<OTPVerification> {

  var verificationCode;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final _pinPutController = TextEditingController();
    final _pinPutFocusNode = FocusNode();

    return Scaffold(

      backgroundColor: Colors.white,
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: 50.h,),
              Container(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined, color: Colors.black,),
                  onPressed: () {
                    controller.phone = widget.countryCode;
                    Get.back();
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 85.h,
                width: size.width,
                child: Column(
                  children: [
                    CustomText(
                      text: "Verify your mobile number".tr,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.black,
                      fontSize: 20.sp,
                      textAlignment: Alignment.topLeft,
                    ),
                    CustomText(
                      text: "Enter the pin you have received via SMS on".tr,
                      fontColor: Colors.black,
                      fontSize: 15.sp,
                      textAlignment: Alignment.topLeft,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 64.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: size.width,
                  height: 100.h,
                  child: PinPut(
                    fieldsCount: 6,
                    withCursor: true,
                    textStyle: const TextStyle(
                        fontSize: 25.0, color: Colors.black),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 55.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: kMainColor,
                      ),
                    ),
                    selectedFieldDecoration: BoxDecoration(
                      color: kMainColor,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: kMainColor,
                      ),
                    ),
                    followingFieldDecoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: kMainColor,
                      ),
                    ),
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      await FirebaseAuth.instance.signInWithCredential(
                          PhoneAuthProvider.credential(
                            verificationId: verificationCode,
                            smsCode: await LanguageLocalStorage()
                                .selectedLanguage == "en" ||  await LanguageLocalStorage()
                                .selectedLanguage == null ? pin : pin
                                .split('')
                                .reversed
                                .join(''),
                          )
                      ).then((value) async {
                        Get.to(() => CompleteUserInfo());
                        await FirebaseAuth.instance.signOut();
                      });
                    },
                  ),
                ),
              )

            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    phoneNumberVerification();
    super.initState();
  }

  Future phoneNumberVerification() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phoneNumber,
        verificationCompleted: (auth) async {
          Get.to(() => CompleteUserInfo());
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Verification Error ", e.message,
              duration: Duration(seconds: 10));
        },
        codeSent: (verificationID, recentToken) {
          setState(() {
            verificationCode = verificationID;
          });
          print("the verificationCode is $verificationCode");
        },
        codeAutoRetrievalTimeout: (verificationID) {
          setState(() {
            verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120)
    );
  }
}