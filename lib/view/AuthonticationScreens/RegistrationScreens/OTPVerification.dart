import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:team_at/helper/constant.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/complete_info_view.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OTPVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;
    final _pinPutController = TextEditingController();
    final _pinPutFocusNode = FocusNode();


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 85.h,
            width: size.width,
            child: Column(
              children: [
                CustomText(
                  text: "Verify your mobile number".tr,
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.black,
                  fontSize: 20.sp,
                  textAlignment: Alignment.topLeft,
                ),
                CustomText(
                  text: "Enter the pin you have received via SMS on".tr,
                  fontColor: Colors.black,
                  fontSize: 15.sp,
                  textAlignment: Alignment.topLeft,
                ),
              ],
            ),
          ),
          SizedBox(height : 64.h),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: size.width,
              height: 100.h,
              child: PinPut(
                fieldsCount: 6,
                withCursor: true,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: kMainColor,
                  ),
                ),
                selectedFieldDecoration: BoxDecoration(
                  color: kMainColor,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: kMainColor,
                  ),
                ),
                followingFieldDecoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: kMainColor,
                  ),
                ),
                pinAnimationType: PinAnimationType.fade,
                onSubmit: (pin) async{
                  Get.to(() => CompleteUserInfo());

                },
              ),
            ),
          )

        ],
      ),
    );
  }
}
