import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';

class EditGroupView extends StatelessWidget {
  final GroupModel thisGroup;

  EditGroupView(this.thisGroup);

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<GroupViewModel>(
        init: GroupViewModel(),
        builder: (controller) => ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios_outlined),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  InkWell(
                    onTap: () {
                      controller.showDialogForChoseImages(context);
                    },
                    child: CircleAvatar(
                      radius: 64.w,
                      backgroundImage: controller.groupImage == null
                          ? NetworkImage(thisGroup.groupPictureURL)
                          : FileImage(controller.groupImage),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: size.width,
                    height: 130.h,
                    child: Column(
                      children: [
                        CustomText(
                          text: "Name group".tr,
                          fontColor: Colors.black,
                          textAlignment: Alignment.centerLeft,
                          fontSize: 16.sp,
                        ),
                        SizedBox(height: 8.h),
                        Expanded(
                          child: TextFormField(
                            initialValue: thisGroup.groupName,
                            onSaved: (val) {
                              controller.groupName = val;
                            },
                            validator: (val) {
                              if (val.isEmpty) return "Group Name Is Empty".tr;
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
                    height: 8.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: size.width,
                    height: 150.h,
                    child: Column(
                      children: [
                        CustomText(
                          text: "Group details".tr,
                          fontColor: Colors.black,
                          textAlignment: Alignment.centerLeft,
                          fontSize: 16.sp,
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: thisGroup.groupDescription,
                            onSaved: (val) {
                              controller.groupDescription = val;
                            },
                            validator: (val) {
                              if (val.isEmpty)
                                Get.snackbar(
                                    "erorr".tr, "Please add Desciption".tr,
                                    snackPosition: SnackPosition.BOTTOM);
                            },
                            maxLines: 6,
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
                    height: 16.h,
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
                                await controller.getGroupLocationLocation();
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
                            text: (controller.groupLatitude == null)
                                ? thisGroup.groupLatitude.toString() +
                                    "," +
                                    thisGroup.groupLongitude.toString()
                                : controller.groupLatitude.toString() +
                                    "," +
                                    controller.groupLongitude.toString(),
                            fontColor: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                      buttonFontSize: 16.sp,
                      buttonHeight: 58.h,
                      buttonWidth: size.width,
                      text: "Save Changes".tr,
                      onClick: () async {
                        if (_key.currentState.validate()) {
                          _key.currentState.save();
                          controller.changeIsLoading(true);
                          if (controller.groupImage != null) {
                            await controller.uploadImage();
                            print("upload done");
                          }
                          await controller.editGroup(GroupModel(
                            groupID: thisGroup.groupID,
                            confirmedUsers: thisGroup.confirmedUsers,
                            unConfirmedUsers: thisGroup.unConfirmedUsers,
                            admin: thisGroup.admin,
                            groupName: controller.groupName == null
                                ? thisGroup.groupName
                                : controller.groupName,
                            groupDescription:
                                controller.groupDescription == null
                                    ? thisGroup.groupDescription
                                    : controller.groupDescription,
                            groupLatitude: controller.groupLatitude == null
                                ? thisGroup.groupLatitude
                                : controller.groupLatitude,
                            groupLongitude: controller.groupLongitude == null
                                ? thisGroup.groupLongitude
                                : controller.groupLongitude,
                            groupPictureURL: controller.groupImageURL == null
                                ? thisGroup.groupPictureURL
                                : controller.groupImageURL,
                          ));
                          controller.changeIsLoading(false);
                          Get.back();
                          Get.back();
                        }
                      },
                      buttonRadius: 9.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
