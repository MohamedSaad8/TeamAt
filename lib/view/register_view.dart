import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/CompeteUserInfo.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(

        child: Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SizedBox(height: size.height *0.15,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: size.height *0.1,
                width: size.width,
                child: Column(
                  children: [
                    CustomText(
                      text: "Getting start".tr,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.black,
                      fontSize: 20,
                      textAlignment: Alignment.topLeft,
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomText(
                      text: "Creating an account to continue".tr,
                      fontColor: Colors.black,
                      fontSize: 15,
                      textAlignment: Alignment.topLeft,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height *0.05,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                height: size.height*0.15,
                child: Column(
                  children: [
                    CustomText(
                      text: "Email".tr,
                      fontColor: Colors.black,
                      textAlignment: Alignment.centerLeft,

                    ),
                    SizedBox(height: size.height * .01,),
                    CustomTextFormField(
                      focusedBorderColor: kSecondColor,
                      prefixIconColor: Color(0xff9a9595),
                      validator: (val){},
                      borderRadius: 12,
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
                height: size.height*0.15,
                child: Column(
                  children: [
                    CustomText(
                      text: "UserName".tr,
                      fontColor: Colors.black,
                      textAlignment: Alignment.centerLeft,

                    ),
                    SizedBox(height: size.height * .01,),
                    CustomTextFormField(
                      prefixIconColor: Color(0xff9a9595),
                      focusedBorderColor: kSecondColor,
                      validator: (val){},
                      borderRadius: 12,
                      onSave: (val){},
                      hintText: "Mohamed saad",
                      prefixIcon: Icons.person_outline_outlined,

                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                height: size.height*0.15,
                child: Column(
                  children: [
                    CustomText(
                      text: "password".tr,
                      fontColor: Colors.black,
                      textAlignment: Alignment.centerLeft,

                    ),
                    SizedBox(height: size.height * .01,),
                    CustomTextFormField(
                      withSuffixIcon: true,
                      prefixIconColor: Color(0xff9a9595),
                      focusedBorderColor: kSecondColor,
                      validator: (val){},
                      borderRadius: 12,
                      onSave: (val){},
                      hintText: "***********",
                      obscureText: true,
                      prefixIcon: Icons.lock,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonHeight: size.height *0.08,
                  buttonWidth: size.width,
                  text: "Sign Up".tr,
                  onClick: (){
                    Get.to(CompleteUserInfo());
                  },
                  buttonRadius: 15.0,
                ),
              ),
            ],
          ),
        ),
      ) ,
    );
  }
}
