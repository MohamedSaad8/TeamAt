import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/CompeteUserInfo.dart';
import 'package:team_at/widget/custom_text.dart';

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
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: size.height *0.12,
              width: size.width,
              child: Column(
                children: [
                  CustomText(
                    text: "Verify your mobile number".tr,
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.black,
                    fontSize: 20,
                    textAlignment: Alignment.topLeft,
                  ),
                  SizedBox(height: size.height * 0.02,),
                  CustomText(
                    text: "Enter the pin you have received via SMS on +201063383029".tr,
                    fontColor: Colors.black,
                    fontSize: 15,
                    textAlignment: Alignment.topLeft,
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.1,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: size.width,
                height: size.height *.15,
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
                    Get.to(CompleteUserInfo());

                  },
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
