import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/register_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';

class LoginView extends StatelessWidget {
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
                      text: "Let's Sign you in".tr,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.black,
                      fontSize: 20,
                      textAlignment: Alignment.topLeft,
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomText(
                      text: "Welcome back we have been missed".tr,
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
              CustomText(
                text: "Forget password ?".tr,
                fontColor: Colors.red,
                fontSize: 12,

              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonHeight: size.height *0.08,
                  buttonWidth: size.width,
                  text: "Sign in".tr,
                  onClick: (){

                  },
                  buttonRadius: 15.0,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
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
              SizedBox(height: size.height * .1,)
            ],
          ),
        ),
      ) ,
    );
  }
}
