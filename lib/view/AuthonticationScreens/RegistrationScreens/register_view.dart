import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/AuthonticationScreens/RegistrationScreens/add_phone_number.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/complete_info_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 34.h,),
            Container(
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
            ), ///85
            SizedBox(height: 24.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              height: 100.h,
              child: Column(
                children: [
                  CustomText(
                    text: "Email".tr,
                    fontColor: Colors.black,
                    textAlignment: Alignment.centerLeft,
                    fontSize: 16.sp,

                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    fieldHeight: 58.h,
                    focusedBorderColor: kSecondColor,
                    prefixIconColor: Color(0xff9a9595),
                    validator: (val){},
                    borderRadius: 0,
                    onSave: (val){},
                    hintText: "saadelnely123@gmail.com",
                    prefixIcon: Icons.email_outlined,
                  ),
                ],
              ),
            ), ///100
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              height: 100.h,
              child: Column(
                children: [
                  CustomText(
                    text: "UserName".tr,
                    fontColor: Colors.black,
                    textAlignment: Alignment.centerLeft,
                    fontSize: 16.sp,

                  ),
                  SizedBox(height: 8.h,),
                  CustomTextFormField(
                    fieldHeight: 58.h,
                    prefixIconColor: Color(0xff9a9595),
                    focusedBorderColor: kSecondColor,
                    validator: (val){},
                    borderRadius: 0,
                    onSave: (val){},
                    hintText: "Mohamed saad",
                    prefixIcon: Icons.person_outline_outlined,

                  ),
                ],
              ),
            ), ///100
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              height: 100.h ,
              child: Column(
                children: [
                  CustomText(
                    text: "password".tr,
                    fontColor: Colors.black,
                    textAlignment: Alignment.centerLeft,
                    fontSize: 16.sp,

                  ),
                  SizedBox(height: 8.h,),
                  CustomTextFormField(
                    fieldHeight: 58.h,
                    withSuffixIcon: true,
                    prefixIconColor: Color(0xff9a9595),
                    focusedBorderColor: kSecondColor,
                    validator: (val){},
                    borderRadius: 0,
                    onSave: (val){},
                    hintText: "***********",
                    obscureText: true,
                    prefixIcon: Icons.lock,
                  ),
                ],
              ),
            ), ///100
            SizedBox(height: 40.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonFontSize: 18.sp,
                buttonHeight: 58.h,
                buttonWidth: size.width,
                text: "Sign Up".tr,
                onClick: (){
                  Get.to(AddPhoneNumber());
                },
                buttonRadius: 9.0,
              ),
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ) ,
    );
  }
}
