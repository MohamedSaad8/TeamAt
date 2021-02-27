import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/add_location_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CompleteUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomText(
                text: "Set your profile photo and your name".tr,
                fontWeight: FontWeight.bold,
                fontColor: Colors.black,
                fontSize: 20.sp,
                textAlignment: Alignment.topLeft,
              ),
            ),
            SizedBox(height: 34.h,),
            Center(
              child: InkWell(
                onTap: (){},
                child: CircleAvatar(
                  radius: 100.w ,
                  backgroundImage:ExactAssetImage("assets/images/avator.jpg") ,
                ),
              ),
            ),
            SizedBox(height: 50.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              height: 100.h,
              child: Column(
                children: [
                  CustomText(
                    text: "Name".tr,
                    fontColor: Colors.black,
                    textAlignment: Alignment.centerLeft,
                    fontSize: 16.sp,

                  ),
                  CustomTextFormField(
                    fieldHeight: 58.h,
                    prefixIconColor: Color(0xff9a9595),
                    focusedBorderColor: kSecondColor,
                    validator: (val){},
                    borderRadius: 9,
                    onSave: (val){},
                    hintText: "mohamed saad",
                    obscureText: false,
                    prefixIcon: Icons.lock,
                  ),
                ],
              ),
            ),
            SizedBox(height: 34.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonHeight: 58.h,
                buttonFontSize: 16.sp,
                buttonWidth: size.width,
                text: "Continue".tr,
                onClick: (){
                  Get.to(CurrentLocationView());

                },
                buttonRadius: 9.0,
              ),
            ),
            SizedBox(height: 20.h,),


          ],
        ),
      ),
    );
  }
}
