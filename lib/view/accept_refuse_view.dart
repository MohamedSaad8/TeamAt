import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';

class AcceptRefuseView extends StatelessWidget {
  final GroupModel thisGroup;

  AcceptRefuseView({this.thisGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GroupViewModel>(
        init: GroupViewModel(),
        builder: (controller) => Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  width: 5.w,
                ),
                CustomText(
                  text: "Requests".tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20.w,
                              backgroundImage: NetworkImage(controller
                                  .getUser(thisGroup.unConfirmedUsers[index])
                                  .picURL),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            CustomText(
                              text: controller
                                  .getUser(thisGroup.unConfirmedUsers[index])
                                  .userName,
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            text: "Accept".tr,
                            buttonFontSize: 14,
                            buttonHeight: 40.h,
                            buttonWidth: 104.w,
                            buttonRadius: 6,
                            onClick: () async {
                              controller.acceptRequest(
                                  thisGroup, thisGroup.unConfirmedUsers[index]);
                            },
                          ),
                          CustomButton(
                            text: "Refuse".tr,
                            buttonFontSize: 14,
                            buttonHeight: 40.h,
                            buttonWidth: 104.w,
                            buttonRadius: 6,
                            onClick: () async {
                              controller.refuseRequest(
                                  thisGroup, thisGroup.unConfirmedUsers[index]);
                            },
                          ),
                        ],
                      )
                    ],
                  );
                },
                itemCount: thisGroup.unConfirmedUsers.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
