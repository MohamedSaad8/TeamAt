import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/view/create_new_group.dart';
import 'package:team_at/view/group_view.dart';

class GroupsView extends StatelessWidget {
  List<GroupModel> myGroupsList = [];
  List<GroupModel> otherGroups = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<GroupViewModel>(
        init: GroupViewModel(),
        builder: (controller) => StreamBuilder<QuerySnapshot>(
          stream: controller.getTeamAtGroups(),
          builder: (context, snapShot) {
            myGroupsList.clear();
            otherGroups.clear();
            if (snapShot.hasData) {
              for (var doc in snapShot.data.docs) {
                var data = doc.data();
                if (data["confirmedUsers"]
                    .contains(UserModel.currentUser.userID)) {
                  try {
                    myGroupsList.add(GroupModel.fromJson(data));
                  } catch (e) {
                    print(e);
                  }
                  print("done");
                } else {
                  otherGroups.add(GroupModel.fromJson(data));
                }
              }
            }
            return snapShot.hasData
                ? Column(
                    children: [
                      SizedBox(
                        height: 70.h,
                      ),
                      createFinfGroup(size),
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomText(
                          text: "My Groups".tr,
                          fontColor: Colors.black,
                          fontSize: 16.sp,
                          textAlignment: Alignment.centerLeft,
                        ),
                      ),
                      Expanded(
                        flex: myGroupsList.length <= 1
                            ? 2
                            : myGroupsList.length == 2
                                ? 3
                                : 8,
                        child: myGroupsList.isNotEmpty
                            ? GetBuilder<PostsViewModel>(
                                init: PostsViewModel(),
                                builder: (postController) => ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await postController
                                                  .getGroupPostsFromFireStore(
                                                      myGroupsList[index]
                                                          .groupID);
                                              Get.to(
                                                () => GroupView(
                                                  thisGroup:
                                                      myGroupsList[index],
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 16.w,
                                                  backgroundImage: NetworkImage(
                                                      myGroupsList[index]
                                                          .groupPictureURL),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                CustomText(
                                                  text: myGroupsList[index]
                                                      .groupName,
                                                  fontSize: 16.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: myGroupsList.length,
                                ),
                              )
                            : CustomText(
                                text: "No Groups Created".tr,
                                fontSize: 18.sp,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Divider(
                        height: 10,
                        color: Colors.grey.shade300,
                        thickness: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomText(
                          text: "Other Groups".tr,
                          fontColor: Colors.black,
                          fontSize: 16.sp,
                          textAlignment: Alignment.centerLeft,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: otherGroups.isNotEmpty
                            ? GetBuilder<PostsViewModel>(
                                init: PostsViewModel(),
                                builder: (postController) => ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await postController
                                                  .getGroupPostsFromFireStore(
                                                      otherGroups[index]
                                                          .groupID);
                                              Get.to(
                                                () => GroupView(
                                                  thisGroup: otherGroups[index],
                                                ),
                                              );
                                            },
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 16.w,
                                                  backgroundImage: NetworkImage(
                                                      otherGroups[index]
                                                          .groupPictureURL),
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                CustomText(
                                                  text: otherGroups[index]
                                                      .groupName,
                                                  fontSize: 16.sp,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: otherGroups.length,
                                ),
                              )
                            : CustomText(
                                text: "No Groups To Join".tr,
                                fontSize: 18.sp,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                      ),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
          },
        ),
      ),
    );
  }

  Container createFinfGroup(Size size) {
    return Container(
      width: size.width,
      height: 42.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Groups".tr,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontColor: Colors.black,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.to(() => CreateGroupView());
                  },
                  child: Container(
                    height: 42.h,
                    width: 42.h,
                    child: Icon(Icons.add),
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
