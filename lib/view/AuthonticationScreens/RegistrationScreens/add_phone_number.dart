import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/OTPVerification.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size ;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 100.h,
              width: size.width,
              child: Column(
                children: [
                  CustomText(
                    text: "Enter your mobile number".tr,
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.black,
                    fontSize: 20.sp,
                    textAlignment: Alignment.topLeft,
                  ),
                  CustomText(
                    text: "Enter your mobile number, we will send a cade to your number".tr,
                    fontColor: Colors.black,
                    fontSize: 15.sp,
                    textAlignment: Alignment.topLeft,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 58.h,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  cursorColor: kMainColor,
                  decoration: InputDecoration(
                    hintText: "0123456789",
                    prefixIcon: CountryCodePicker(
                      initialSelection: 'EG',
                      favorite: ["+20" , "EG"],
                      showFlag: true,
                      onChanged: (code){
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kSecondColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 230.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                buttonHeight:58.h,
                buttonWidth: size.width,
                text: "Continue".tr,
                onClick: (){
                  Get.to(OTPVerification());

                },
                buttonRadius: 9,
              ),
            ),
            SizedBox(height: 20.h,)
          ],
        ),
      ),
    );
  }
}
