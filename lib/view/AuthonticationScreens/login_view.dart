import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/register_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 124.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 85.h,
              width: size.width,
              child: Column(
                children: [
                  CustomText(
                    text: "Let's Sign you in".tr,
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.black,
                    fontSize: 20.sp,
                    textAlignment: Alignment.topLeft,
                  ),
                  CustomText(
                    text: "Welcome back we have been missed".tr,
                    fontColor: Colors.black,
                    fontSize: 15.sp,
                    textAlignment: Alignment.topLeft,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.sp,),
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
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              height: 100.h,
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
            ),
            CustomText(
              text: "Forget password ?".tr,
              fontColor: Colors.red,
              fontSize: 12,

            ),
            SizedBox(
              height: 68.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonHeight: 58.h,
                buttonWidth: size.width,
                text: "Sign in".tr,
                onClick: (){

                },
                buttonRadius: 9.0,
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Don't have an account?".tr,
                  fontColor: Color(0xff757575),
                  fontSize: 12,

                ),
                InkWell(
                  onTap: (){
                    Get.to(RegisterView()) ;
                  },
                  child: CustomText(
                    text: "Sign Up".tr,
                    fontColor: kMainColor,
                    fontSize: 12,

                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ) ,
    );
  }
}
