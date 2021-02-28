import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_at/view/controll_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrentLocationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: Column(
        children: [
          Image.asset("assets/images/location.png" ,
          width: 128.w,
          height: 216.h,),
          SizedBox(height: 24.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomText(
              text: "Set your location so you can see the neighboring groups".tr,
              fontWeight: FontWeight.bold,
              fontColor: Colors.black,
              fontSize: 20.sp,
              textAlignment: Alignment.topLeft,
            ),
          ),
          SizedBox(height: 50.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 58.h,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: InkWell(
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Colors.grey.shade700,
                        size: 30.w,
                      ),
                    ),
                  ),
                  SizedBox(width:  40.h,),
                  CustomText(
                    text: "Set your location".tr,
                    fontColor: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(
              buttonFontSize: 16.sp,
              buttonHeight:58.h,
              buttonWidth: size.width,
              text: "Continue".tr,
              onClick: (){
                print("clicked");
                    Get.to(()=>FunLifeMainScreen()) ;
              },
              buttonRadius: 9.0,
            ),
          ),
          SizedBox(height:20.h,)


        ],
      ),

    );
  }
}
