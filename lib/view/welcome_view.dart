import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/view/login_view.dart';
import 'package:team_at/view/register_with_phone.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';

class WelcomeView  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(height: size.height *0.15,),
            Image.asset("assets/images/welcom.png" , width: size.width, height:size.height * 0.3,),
            SizedBox(height: size.height *0.05,),
            Container(
              width: size.width,
              height:size.height *0.1 ,
              child: Column(
                children: [
                  CustomText(
                    text: "welcome to our team @".tr,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: "social app".tr,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height *0.05,),
            Container(
              width: size.width,
              height:size.height *0.1 ,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: "Team @ talk any person of your".tr,
                    fontColor: Color(0xff9a9595),
                    fontSize: 15,

                  ),
                  CustomText(
                    text: "mother language".tr,
                    fontColor: Color(0xff9a9595),
                    fontSize: 15,
                  ),
                ],
              ),
            ),
            Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15),
             child: Column(
               children: [
                 CustomButton(
                   buttonHeight: size.height *0.08,
                   buttonWidth: size.width,
                   text: "Start With Phone".tr,
                   onClick: (){
                     Get.to(RegisterWithPhoneNumber());

                   },
                   buttonRadius: 20.0,
                 ),
                 SizedBox(
                    height : size.height *0.04
                 ),
                 CustomButton(
                   buttonHeight: size.height *0.08,
                   buttonWidth: size.width,
                   text: "Start With Email".tr,
                   onClick: (){
                     Get.to(LoginView());
                   },
                   buttonRadius: 20.0,
                 ),
               ],
             ),
           ),
            SizedBox(height: 0.1,)
          ],
        ),
      ),
    );
  }
}

