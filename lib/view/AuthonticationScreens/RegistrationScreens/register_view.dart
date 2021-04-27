import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/AuthonticationScreens/RegistrationScreens/add_phone_number.dart';
import 'package:team_at/view/AuthonticationScreens/RegistrationScreens/complete_info_view.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder:  (controller) => SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  height: 34.h,
                ),
                _headTitle(size),
                SizedBox(
                  height: 24.h,
                ),
                _emailField(size , controller),
                userNameField(size , controller),
                passwordField(size , controller),
                SizedBox(
                  height: 40.h,
                ),
                signUpButton(size),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding signUpButton(Size size ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomButton(
        buttonFontSize: 18.sp,
        buttonHeight: 58.h,
        buttonWidth: size.width,
        text: "Sign Up".tr,
        onClick: () {
          if(_key.currentState.validate())
          {
            _key.currentState.save();
           // Get.to(() => AddPhoneNumber());  //For android
            Get.to(() => CompleteUserInfo()); ///for ios
          }
        },
        buttonRadius: 9.0,
      ),
    );
  }

  Container passwordField(Size size , AuthViewModel controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: 130.h,
      child: Column(
        children: [
          CustomText(
            text: "password".tr,
            fontColor: Colors.black,
            textAlignment: Alignment.centerLeft,
            fontSize: 16.sp,
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: CustomTextFormField(
              fieldHeight: 58.h,
              withSuffixIcon: true,
              prefixIconColor: Color(0xff9a9595),
              focusedBorderColor: kSecondColor,
              validator: (val) {
                if(val.isEmpty)
                  return "passwordEmpty".tr ;
                if(val.length < 6)
                  return "lengthError".tr;
              },
              borderRadius: 0,
              onSave: (val) {
                controller.password = val ;
              },
              hintText: "***********",
              obscureText: true,
              prefixIcon: Icons.lock,
            ),
          ),
        ],
      ),
    );
  }

  Container userNameField(Size size , AuthViewModel controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: 130.h,
      child: Column(
        children: [
          CustomText(
            text: "username".tr,
            fontColor: Colors.black,
            textAlignment: Alignment.centerLeft,
            fontSize: 16.sp,
          ),
          SizedBox(
            height: 8.h,
          ),
          Expanded(
            child: CustomTextFormField(
              fieldHeight: 58.h,
              prefixIconColor: Color(0xff9a9595),
              focusedBorderColor: kSecondColor,
              validator: (val) {
                if(val.isEmpty)
                  return "userNameEmpty".tr ;
              },
              borderRadius: 0,
              onSave: (val) {
                controller.userName = val ;
              },
              hintText: "Mohamed saad",
              prefixIcon: Icons.person_outline_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Container _emailField(Size size, AuthViewModel controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: 130.h,
      child: Column(
        children: [
          CustomText(
            text: "Email".tr,
            fontColor: Colors.black,
            textAlignment: Alignment.centerLeft,
            fontSize: 16.sp,
          ),
          SizedBox(height: 8.h),
          Expanded(
            child: CustomTextFormField(
              fieldHeight: 58.h,
              focusedBorderColor: kSecondColor,
              prefixIconColor: Color(0xff9a9595),
              validator: (val) {
                if(val.isEmpty)
                  return "emailEmpty".tr ;
                if(GetUtils.isEmail(val) == false)
                  return "badForm".tr;
              },
              borderRadius: 0,
              onSave: (val) {
                controller.email = val ;
              },
              hintText: "saadelnely123@gmail.com",
              prefixIcon: Icons.email_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Container _headTitle(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 85.h,
      width: size.width,
      child: Column(
        children: [
          CustomText(
            text: "GettingStart".tr,
            fontWeight: FontWeight.bold,
            fontColor: Colors.black,
            fontSize: 20.sp,
            textAlignment: Alignment.topLeft,
          ),
          CustomText(
            text: "Creating an account to continue".tr,
            fontColor: Colors.black,
            fontSize: 15.sp,
            textAlignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }
}