import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';

class EditProfile extends StatelessWidget {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (authController) => ModalProgressHUD(
          inAsyncCall: authController.isLoading,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                    ),
                    onTap: () {
                      authController.profileImage = null;
                      Get.back();
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      authController.showDialogForChoseImages(context);
                    },
                    child: CircleAvatar(
                      radius: 80.h,
                      backgroundImage: authController.profileImage == null
                          ? NetworkImage(UserModel.currentUser.picURL)
                          : FileImage(authController.profileImage),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Form(
                  key: globalKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            CustomText(text: "username".tr),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: UserModel.currentUser.userName,
                                onSaved: (val) {
                                  authController.userName = val;
                                },
                                validator: (val) {
                                  if (val.isEmpty) return "username is empty".tr;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20.h),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kMainColor,
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            CustomText(text: "phone".tr),
                            SizedBox(
                              width: 35.w,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: UserModel.currentUser.phone,
                                onSaved: (val) {
                                  authController.phone = val;
                                },
                                validator: (val) {
                                  if (val.isEmpty) return "phone Is Empty".tr;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20.h),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kMainColor,
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            CustomText(text: "Bio".tr),
                            SizedBox(
                              width: 60.w,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: UserModel.currentUser.name,
                                onSaved: (val) {
                                  authController.name = val;
                                },
                                validator: (val) {
                                  if (val.isEmpty) return "Bio Is Empty".tr;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(20.h),
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kMainColor,
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomText(text: "Location".tr),
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                height: 58.h,
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
                                          await authController.getUserLocation();
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
                                      text: authController.longitude == null
                                          ? UserModel.currentUser.latitude
                                                  .toString() +
                                              "," +
                                              UserModel.currentUser.longitude
                                                  .toString()
                                          : authController.latitude.toString() +
                                              "," +
                                              authController.longitude.toString(),
                                      fontColor: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomButton(
                          buttonFontSize: 16.sp,
                          buttonHeight: 58.h,
                          buttonWidth: size.width,
                          text: "Save Changes".tr,
                          onClick: () async {
                            if (globalKey.currentState.validate()) {
                              globalKey.currentState.save();
                              authController.changeIsLoading(true);
                              if (authController.profileImage != null) {
                                await authController.uploadImage();
                                print("upload done");
                              }
                              await authController.editProfileData(
                                UserModel(
                                  country: authController.country == null
                                      ? UserModel.currentUser.country
                                      : authController.country,
                                  userName: authController.userName == null
                                      ? UserModel.currentUser.userName
                                      : authController.userName,
                                  userID: UserModel.currentUser.userID,
                                  email: UserModel.currentUser.email,
                                  picURL: authController.profileImageUrl == null
                                      ? UserModel.currentUser.picURL
                                      : authController.profileImageUrl,
                                  phone: authController.phone == null
                                      ? UserModel.currentUser.phone
                                      : authController.phone,
                                  name: authController.name == null
                                      ? UserModel.currentUser.name
                                      : authController.name,
                                  latitude: authController.latitude == null
                                      ? UserModel.currentUser.latitude
                                      : authController.latitude,
                                  longitude: authController.longitude == null
                                      ? UserModel.currentUser.longitude
                                      : authController.longitude,
                                ),
                              );
                              authController.changeIsLoading(false);
                              Get.back();
                            }
                          },
                          buttonRadius: 9.0,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
