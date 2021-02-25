import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/OTPVerification.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';

class RegisterWithPhoneNumber extends StatelessWidget {
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
        child: Container(
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
                      text: "Enter your mobile number".tr,
                      fontWeight: FontWeight.bold,
                      fontColor: Colors.black,
                      fontSize: 20,
                      textAlignment: Alignment.topLeft,
                    ),
                    SizedBox(height: size.height * 0.02,),
                    CustomText(
                      text: "Enter your mobile number, we will sent a cade to your number".tr,
                      fontColor: Colors.black,
                      fontSize: 15,
                      textAlignment: Alignment.topLeft,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.05,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kSecondColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * .3,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonHeight: size.height *0.08,
                  buttonWidth: size.width,
                  text: "Continue".tr,
                  onClick: (){
                    Get.to(OTPVerification());

                  },
                  buttonRadius: 15.0,
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
