import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/post_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/view/comment_view.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/view/edit_profile.dart';

class ProfileView extends StatelessWidget {
  List<PostModel> userPosts = [];
  UserModel currentUser;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: GetBuilder<PostsViewModel>(
          init: PostsViewModel(),
          builder: (postController) {
            return StreamBuilder<QuerySnapshot>(
              stream: postController.getTimeLinePosts(),
              builder: (context, snapShot) {
                userPosts.clear();
                try {
                  for (var doc in snapShot.data.docs) {
                    var data = doc.data();
                    if (data["userId"] == UserModel.currentUser.userID) {
                      userPosts.add(PostModel.fromJson(data));
                    }
                  }
                } catch (e) {
                  userPosts = [];
                }
                return userPosts.isNotEmpty && userPosts.length > 0
                    ? GetBuilder<AuthViewModel>(
                        init: AuthViewModel(),
                        builder: (controller) => ListView.builder(
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return StreamBuilder<QuerySnapshot>(
                                  stream: controller.getUserData(),
                                  builder: (context, snapShot1) {
                                    try {
                                      for (var doc in snapShot1.data.docs) {
                                        var data = doc.data();
                                        if (data["userID"] ==
                                            UserModel.currentUser.userID) {
                                          currentUser =
                                              UserModel.fromJson(data);
                                        }
                                      }
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Container(
                                            width: size.width,
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: CircleAvatar(
                                                    radius: 60.w,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            currentUser.picURL),
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.settings,
                                                      color: Colors.grey,
                                                    ),
                                                    onPressed: () async {
                                                      Get.to(EditProfile());
                                                    },
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child:
                                                      GetBuilder<AuthViewModel>(
                                                    init: AuthViewModel(),
                                                    builder: (controller) =>
                                                        IconButton(
                                                      icon: Icon(
                                                        Icons.exit_to_app,
                                                        color: Colors.grey,
                                                      ),
                                                      onPressed: () async {
                                                        await controller
                                                            .signOut();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 4.h,
                                          ),
                                          CustomText(
                                            text: currentUser.userName,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          SizedBox(
                                            height: 16.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Container(
                                              height: 70.h,
                                              width: size.width,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      CustomText(
                                                        text: postController
                                                            .userPosts.length
                                                            .toString(),
                                                        fontSize: 16.sp,
                                                        fontColor: kSecondColor,
                                                      ),
                                                      CustomText(
                                                        text: "Posts".tr,
                                                        fontSize: 16.sp,
                                                        fontColor: kSecondColor,
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      CustomText(
                                                        text: postController
                                                            .myGroups
                                                            .toString(),
                                                        fontSize: 16.sp,
                                                        fontColor: Colors.black,
                                                      ),
                                                      CustomText(
                                                        text: "My groups".tr,
                                                        fontSize: 16.sp,
                                                        fontColor: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      CustomText(
                                                        text: postController
                                                            .followingGroups
                                                            .toString(),
                                                        fontSize: 16.sp,
                                                        fontColor: Colors.black,
                                                      ),
                                                      CustomText(
                                                        text: "Following groups"
                                                            .tr,
                                                        fontSize: 16.sp,
                                                        fontColor: Colors.grey,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.h,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: CustomText(
                                              text: "My Bio".tr,
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold,
                                              textAlignment: Alignment.topLeft,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: CustomText(
                                              text: currentUser.name,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.normal,
                                              textAlignment: Alignment.topLeft,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 24.h,
                                          )
                                        ],
                                      );
                                    } catch (e) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      );
                                    }
                                  });
                            }
                            try {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 12, top: 0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: size.width,
                                        height: 0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 16,
                                              backgroundImage: NetworkImage(
                                                  UserModel.currentUser.picURL),
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: postController
                                                      .getGroup(
                                                          userPosts[index - 1]
                                                              .groupId)
                                                      .groupName,
                                                  fontSize: 14.sp,
                                                ),
                                                CustomText(
                                                  text: UserModel
                                                      .currentUser.userName,
                                                  fontSize: 14.sp,
                                                  fontColor: Colors.grey,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      LayoutBuilder(
                                        builder: (context, constrain) {
                                          if (userPosts[index - 1]
                                                  .postContent !=
                                              "") {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 12),
                                              child: CustomText(
                                                text: userPosts[index - 1]
                                                    .postContent,
                                                textAlignment:
                                                    Alignment.centerLeft,
                                                fontSize: 16.sp,
                                              ),
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            minHeight: 10.h, minWidth: 370.w),
                                        child:
                                            userPosts[index - 1].postImageURL !=
                                                    null
                                                ? Image(
                                                    image: NetworkImage(
                                                        userPosts[index - 1]
                                                            .postImageURL))
                                                : Container(),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: GestureDetector(
                                              onTap: () async {
                                                if (userPosts[index - 1]
                                                    .likes
                                                    .contains(UserModel
                                                        .currentUser.userID))
                                                  postController.removeLike(
                                                      userPosts[index - 1]);
                                                else
                                                  postController.addLike(
                                                      userPosts[index - 1]);
                                              },
                                              child: Icon(
                                                Icons.favorite_border_outlined,
                                                size: 30.w,
                                                color: userPosts[index - 1]
                                                        .likes
                                                        .contains(UserModel
                                                            .currentUser.userID)
                                                    ? Colors.red
                                                    : Colors.black,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await postController
                                                  .getPostCommentsFromFireStore(
                                                      userPosts[index - 1]
                                                          .postId);

                                              Get.to(
                                                () => CommentView(
                                                  thisGroup:
                                                      postController.getGroup(
                                                          userPosts[index - 1]
                                                              .groupId),
                                                  thePost: userPosts[index - 1],
                                                  postId: userPosts[index - 1]
                                                      .postId,
                                                ),
                                              );
                                            },
                                            child: Container(
                                              child: Image(
                                                image: ExactAssetImage(
                                                    "assets/images/commentIcon.png"),
                                                //sss width: 35.w,
                                                height: 35.w,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Row(
                                          children: [
                                            CustomText(
                                              text: userPosts[index - 1]
                                                      .likes
                                                      .length
                                                      .toString() +
                                                  " Likes".tr,
                                              fontSize: 14,
                                              fontColor: Colors.grey,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            CustomText(
                                              text: (userPosts[index - 1]
                                                              .comments !=
                                                          null &&
                                                      userPosts[index - 1]
                                                              .comments
                                                              .length >
                                                          0)
                                                  ? userPosts[index - 1]
                                                          .comments
                                                          .length
                                                          .toString() +
                                                      " Comments".tr
                                                  : "0 Comments".tr,
                                              fontSize: 14,
                                              fontColor: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            } catch (e) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                          },
                          itemCount: userPosts.length + 1,
                        ),
                      )
                    : GetBuilder<AuthViewModel>(
                        init: AuthViewModel(),
                        builder: (controller) => StreamBuilder<QuerySnapshot>(
                            stream: controller.getUserData(),
                            builder: (context, snapShot1) {
                              try {
                                for (var doc in snapShot1.data.docs) {
                                  var data = doc.data();
                                  if (data["userID"] ==
                                      UserModel.currentUser.userID) {
                                    currentUser = UserModel.fromJson(data);
                                  }
                                }
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    Container(
                                      width: size.width,
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: CircleAvatar(
                                              radius: 60.w,
                                              backgroundImage: NetworkImage(
                                                  currentUser.picURL),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.settings,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () async {
                                                Get.to(EditProfile());
                                              },
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: GetBuilder<AuthViewModel>(
                                              init: AuthViewModel(),
                                              builder: (controller) =>
                                                  IconButton(
                                                icon: Icon(
                                                  Icons.exit_to_app,
                                                  color: Colors.grey,
                                                ),
                                                onPressed: () async {
                                                  await controller.signOut();
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4.h,
                                    ),
                                    CustomText(
                                      text: currentUser.userName,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Container(
                                        height: 65.h,
                                        width: size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: postController
                                                      .userPosts.length
                                                      .toString(),
                                                  fontSize: 16.sp,
                                                  fontColor: kSecondColor,
                                                ),
                                                CustomText(
                                                  text: "Posts".tr,
                                                  fontSize: 16.sp,
                                                  fontColor: kSecondColor,
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: postController.myGroups
                                                      .toString(),
                                                  fontSize: 16.sp,
                                                  fontColor: Colors.black,
                                                ),
                                                CustomText(
                                                  text: "My groups".tr,
                                                  fontSize: 16.sp,
                                                  fontColor: Colors.grey,
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: postController
                                                      .followingGroups
                                                      .toString(),
                                                  fontSize: 16.sp,
                                                  fontColor: Colors.black,
                                                ),
                                                CustomText(
                                                  text: "Following groups".tr,
                                                  fontSize: 16.sp,
                                                  fontColor: Colors.grey,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: CustomText(
                                        text: "My Bio".tr,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        textAlignment: Alignment.topLeft,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: CustomText(
                                        text: currentUser.name,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        textAlignment: Alignment.topLeft,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    )
                                  ],
                                );
                              } catch (e) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                );
                              }
                            }),
                      );
              },
            );
          }),
    );
  }
}
