import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/view/message_view.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/widget/custom_text.dart';

class ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body :  GetBuilder<GroupViewModel>(
          init: GroupViewModel(),
          builder: (groupController) => Container(

            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomText(
                    text: "My Groups Chats".tr,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    textAlignment: Alignment.centerLeft,
                  ),
                ),
                Divider(color: Colors.grey,),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Get.to( MessageView(
                            group: groupController.myGroupsList[index],
                          ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.w,
                                  backgroundImage: NetworkImage(
                                      groupController
                                          .myGroupsList[index]
                                          .groupPictureURL),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                CustomText(
                                  text: groupController
                                      .myGroupsList[index].groupName,
                                  fontSize: 16.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: groupController.myGroupsList.length,
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}