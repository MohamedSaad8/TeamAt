import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/view/create_new_group.dart';
import 'package:team_at/view/group_view.dart';

class GroupsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<GroupViewModel>(
        init: GroupViewModel(),
        builder: (controller) => Column(
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
                text: "My Groups",
                fontColor: Colors.black,
                fontSize: 16.sp,
                textAlignment: Alignment.centerLeft,
              ),
            ),
            Expanded(
              flex: controller.myGroupsList.length <= 1
                  ? 2
                  : controller.myGroupsList.length == 2
                      ? 3
                      : 8,
              child: controller.myGroupsList.isNotEmpty
                  ? GetBuilder<PostsViewModel>(
                      init: PostsViewModel(),
                      builder: (postController) => ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await postController
                                        .getGroupPostsFromFireStore(controller
                                            .myGroupsList[index].groupID);
                                    Get.to(
                                      () => GroupView(
                                        thisGroup:
                                            controller.myGroupsList[index],
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16.w,
                                        backgroundImage: NetworkImage(controller
                                            .myGroupsList[index]
                                            .groupPictureURL),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      CustomText(
                                        text: controller
                                            .myGroupsList[index].groupName,
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
                        itemCount: controller.myGroupsList.length,
                      ),
                    )
                  : CustomText(
                      text: "No Groups Created",
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: CustomText(
                text: "Other Groups",
                fontColor: Colors.black,
                fontSize: 16.sp,
                textAlignment: Alignment.centerLeft,
              ),
            ),
            Expanded(
              flex: 10,
              child: controller.otherGroups.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => GroupView(
                                      thisGroup: controller.otherGroups[index],
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16.w,
                                      backgroundImage: NetworkImage(controller
                                          .otherGroups[index].groupPictureURL),
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    CustomText(
                                      text: controller
                                          .otherGroups[index].groupName,
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
                      itemCount: controller.otherGroups.length,
                    )
                  : CustomText(
                      text: "No Joined Groups",
                      fontSize: 18.sp,
                      fontColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
            ),
          ],
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
                    text: "Groups",
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
                      SizedBox(
                        width: 5.w,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 42.h,
                          width: 42.h,
                          child: Icon(Icons.location_on_outlined),
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
