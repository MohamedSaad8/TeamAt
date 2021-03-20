import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/add_location_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CompleteUserInfo extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (controller) => ModalProgressHUD (
          inAsyncCall : controller.isLoading ,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomText(
                    text: "Set your profile photo and your name".tr,
                    fontWeight: FontWeight.bold,
                    fontColor: Colors.black,
                    fontSize: 20.sp,
                    textAlignment: Alignment.topLeft,
                  ),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      controller.showDialogForChoseImages(context);
                    },
                    child: CircleAvatar(
                      radius: 100.w,
                      backgroundImage: controller.profileImage == null ? AssetImage("assets/images/avator.jpg") :
                      FileImage(controller.profileImage),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: size.width,
                  height: 130.h,
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        CustomText(
                          text: "Bio".tr,
                          fontColor: Colors.black,
                          textAlignment: Alignment.centerLeft,
                          fontSize: 16.sp,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Expanded(
                          child: CustomTextFormField(
                            fieldHeight: 58.h,
                            prefixIconColor: Color(0xff9a9595),
                            focusedBorderColor: kSecondColor,
                            validator: (val) {
                              if (val.isEmpty) return "BioEmpty".tr;
                            },
                            borderRadius: 0,
                            onSave: (val) {
                              controller.name = val;
                            },
                            hintText: "mohamed saad",
                            obscureText: false,
                            prefixIcon: Icons.lock,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 34.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    buttonHeight: 58.h,
                    buttonFontSize: 16.sp,
                    buttonWidth: size.width,
                    text: "Continue".tr,
                    onClick: () async {
                      if (_key.currentState.validate()){
                        _key.currentState.save();
                        if(controller.profileImage !=null)
                        {
                          controller.changeIsLoading(true);
                          await controller.uploadImage();
                          controller.changeIsLoading(false) ;
                          Get.to(CurrentLocationView());
                        }

                      }
                    },
                    buttonRadius: 9.0,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}