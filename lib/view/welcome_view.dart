import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/view/controll_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WelcomeView  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 131.h,),
          Image.asset("assets/images/welcom.png" , width: 375.sw, height: 260.h,),
          SizedBox(height: 48.h,),
          Container(
            width: size.width,
            height:77.h ,
            child: Column(
              children: [
                CustomText(
                  text: "welcome to our team @".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: "social app".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h,),
          Container(
            width: size.width,
            height:60.h ,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: "Team @ talk any person of your".tr,
                  fontColor: Color(0xff9a9595),
                  fontSize: 15.sp,

                ),
                CustomText(
                  text: "mother language".tr,
                  fontColor: Color(0xff9a9595),
                  fontSize: 15.sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 83.h,),
          Padding(
           padding: const EdgeInsets.symmetric(horizontal: 15),
           child: CustomButton(
             buttonFontSize: 16.sp,
             buttonHeight: 58.h,
             buttonWidth: size.width,
             text: "GettingStart".tr,
             onClick: (){
               Get.off(() => ControlView());
             },
             buttonRadius: 9,
           ),
         ),
          SizedBox(height: 68.h,)
        ],
      ),
    );
  }
}

