import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
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
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (controller) => ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          child: Column(
            children: [
              InkWell(
                onTap: ()async{
                  controller.changeIsLoading(true);
                  await controller.getUserLocation();
                  controller.changeIsLoading(false) ;
                },
                child: Image.asset(
                  "assets/images/location.png",
                  width: 128.w,
                  height: 216.h,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(
                  text: "Set your location so you can see the neighboring groups"
                      .tr,
                  fontWeight: FontWeight.bold,
                  fontColor: Colors.black,
                  fontSize: 20.sp,
                  textAlignment: Alignment.topLeft,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
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
                          onTap: () async {
                            controller.changeIsLoading(true);
                            await controller.getUserLocation();
                            controller.changeIsLoading(false) ;
                          },
                          child: Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey.shade700,
                            size: 30.w,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.h,
                      ),
                      CustomText(
                        text: controller.longitude == null
                            ? "Set your location".tr
                            : controller.longitude.toString() +
                            "," +
                            controller.latitude.toString(),
                        fontColor: Colors.grey.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  buttonFontSize: 16.sp,
                  buttonHeight: 58.h,
                  buttonWidth: size.width,
                  text: "Continue".tr,
                  onClick: () {
                    if(controller.latitude != null){
                      controller.createAccountWithEmailAndPassword();
                    }
                    else
                      Get.snackbar("locationError".tr, "selectLocation".tr ,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 3),
                      );

                  },
                  buttonRadius: 9.0,
                ),
              ),
              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}