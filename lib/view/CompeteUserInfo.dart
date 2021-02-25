import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/currentLocationView.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';

class CompleteUserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: "Set your profile photo and your name".tr,
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.black,
                  fontSize: 20,
                  textAlignment: Alignment.topLeft,
                ),
              ),
              SizedBox(height: size.height * 0.05,),
              Container(
                width: size.width,
                height: size.height * .2,
                child: Center(
                  child: InkWell(
                    onTap: (){},
                    child: CircleAvatar(
                      radius: size.height * .1 ,
                      backgroundImage:ExactAssetImage("assets/images/avator.jpg") ,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                height: size.height*0.15,
                child: Column(
                  children: [
                    CustomText(
                      text: "Name".tr,
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
                      hintText: "mohamed saad",
                      obscureText: false,
                      prefixIcon: Icons.lock,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonHeight: size.height *0.08,
                  buttonWidth: size.width,
                  text: "continue".tr,
                  onClick: (){
                    Get.to(CurrentLocationView());

                  },
                  buttonRadius: 15.0,
                ),
              ),
              SizedBox(height: size.height * 0.1,),


            ],
          ),

        ),
      ),
    );
  }
}
