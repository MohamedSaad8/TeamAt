import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/OTPVerification.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPhoneNumber extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (controller) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 100.h,
                width: size.width,
                child: headTitle(),
              ),
              SizedBox(
                height: 32.h,
              ),
              Form(
                key: _key,
                child: phoneField(controller),
              ),
              SizedBox(
                height: 230.h,
              ),
              addPhoneButton(size , controller),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding addPhoneButton(Size size , AuthViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomButton(
        buttonHeight: 58.h,
        buttonWidth: size.width,
        text: "Continue".tr,
        onClick: () async {
          if(_key.currentState.validate())
          {
            _key.currentState.save();
            Get.to(() => OTPVerification(phoneNumber: controller.phone,));
          }

        },
        buttonRadius: 9,
      ),
    );
  }

  Padding phoneField( AuthViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 130.h,
        child: TextFormField(
          keyboardType: TextInputType.number,
          cursorColor: kMainColor,
          onSaved: (value)
          {
            controller.phone = controller.phone + value ;
            print(controller.phone);

          },
          validator: (value)
          {
            if(value.isEmpty)
              return  "phoneEmpty".tr ;
          },
          decoration: InputDecoration(
            hintText: "0123456789",
            prefixIcon: CountryCodePicker(
              initialSelection: 'EG',
              favorite: ["+20", "EG"],
              showFlag: true,
              onChanged: (code) {
                controller.phone = code.toString() ;
              },
              onInit: (code){
                controller.phone = code.toString() ;
                print(controller.phone);
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
    );
  }

  Column headTitle() {
    return Column(
      children: [
        CustomText(
          text: "Enter your mobile number".tr,
          fontWeight: FontWeight.bold,
          fontColor: Colors.black,
          fontSize: 20.sp,
          textAlignment: Alignment.topLeft,
        ),
        CustomText(
          text:
          "Enter your mobile number, we will send a cade to your number".tr,
          fontColor: Colors.black,
          fontSize: 15.sp,
          textAlignment: Alignment.topLeft,
        ),
      ],
    );
  }
}