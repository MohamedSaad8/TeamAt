import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/post_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/view/message_view.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:team_at/view/accept_refuse_view.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/view/create_post_view.dart';
import 'package:team_at/view/comment_view.dart';
import 'package:team_at/view/edit_group_view.dart';
import 'package:team_at/view/edit_post.dart';


class GroupView extends StatelessWidget {
  final GroupModel thisGroup;
  List<PostModel> groupPosts = [];

  GroupView({this.thisGroup});

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<GroupViewModel>(
        init: GroupViewModel(),
        builder: (controller) => Column(
          children: [
            Expanded(
              child: GetBuilder<PostsViewModel>(
                  init: PostsViewModel(),
                  builder: (postController) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: postController.getGroupPosts(),
                      builder: (context, snapShot) {
                        groupPosts.clear();
                        try {
                          for (var doc in snapShot.data.docs) {
                            var data = doc.data();
                            if (data["groupId"] == thisGroup.groupID) {
                              groupPosts.add(PostModel.fromJson(data));
                            }
                          }
                        } catch (e) {
                          groupPosts = [];
                        }
                        return groupPosts.isNotEmpty && groupPosts.length > 0
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return Column(
                                      children: [
                                        Container(
                                          width: size.width,
                                          height: 240.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                thisGroup.groupPictureURL,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                child: CustomText(
                                                  text: thisGroup.groupName,
                                                  fontWeight: FontWeight.bold,
                                                  fontColor: Colors.white,
                                                  fontSize: 18.sp,
                                                ),
                                                top: 180.h,
                                                //bottom: 35.h,
                                                left: 16.h,
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 25.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_back_ios_outlined,
                                                        color: kSecondColor,
                                                      ),
                                                      onPressed: () {
                                                        Get.back();
                                                        Get.back();
                                                        Get.back();
                                                        Get.back();
                                                        Get.back();
                                                        Get.back();
                                                        Get.back();
                                                        Get.back();
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: thisGroup.admin ==
                                                              UserModel
                                                                  .currentUser
                                                                  .userID
                                                          ? Icon(
                                                              Icons
                                                                  .more_vert_outlined,
                                                              color:
                                                                  kSecondColor,
                                                            )
                                                          : Container(),
                                                      onPressed: thisGroup
                                                                  .admin ==
                                                              UserModel
                                                                  .currentUser
                                                                  .userID
                                                          ? () {
                                                              Get.to(
                                                                () =>
                                                                    AcceptRefuseView(
                                                                  thisGroup:
                                                                      thisGroup,
                                                                ),
                                                              );
                                                            }
                                                          : null,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 180.h,
                                                right: 16.w,
                                                child: CustomButton(
                                                  text: thisGroup.admin ==
                                                          UserModel.currentUser
                                                              .userID
                                                      ? "Edit group".tr
                                                      : thisGroup.confirmedUsers
                                                              .contains(UserModel
                                                                  .currentUser
                                                                  .userID)
                                                          ? "Leave Group".tr
                                                          : thisGroup
                                                                  .unConfirmedUsers
                                                                  .contains(UserModel
                                                                      .currentUser
                                                                      .userID)
                                                              ? "cancel request"
                                                                  .tr
                                                              : "Join Group".tr,
                                                  buttonFontSize: 14.sp,
                                                  buttonHeight: 40.h,
                                                  buttonWidth: 104.w,
                                                  buttonRadius: 6,
                                                  onClick: () async {
                                                    if (thisGroup.admin ==
                                                        UserModel.currentUser
                                                            .userID) {
                                                      Get.to(() =>
                                                          EditGroupView(
                                                              thisGroup));
                                                    } else if (thisGroup
                                                            .unConfirmedUsers
                                                            .contains(UserModel
                                                                .currentUser
                                                                .userID) ==
                                                        true) {
                                                      await controller
                                                          .cancelRequest(
                                                              thisGroup);
                                                    } else if (thisGroup
                                                                .unConfirmedUsers
                                                                .contains(UserModel
                                                                    .currentUser
                                                                    .userID) ==
                                                            false &&
                                                        thisGroup.confirmedUsers
                                                                .contains(UserModel
                                                                    .currentUser
                                                                    .userID) ==
                                                            false &&
                                                        thisGroup.admin !=
                                                            UserModel
                                                                .currentUser
                                                                .userID) {
                                                      await controller
                                                          .joinToGroup(
                                                              thisGroup);
                                                    } else if (thisGroup
                                                                .unConfirmedUsers
                                                                .contains(UserModel
                                                                    .currentUser
                                                                    .userID) ==
                                                            false &&
                                                        thisGroup.confirmedUsers
                                                            .contains(UserModel
                                                                .currentUser
                                                                .userID) &&
                                                        thisGroup.admin !=
                                                            UserModel
                                                                .currentUser
                                                                .userID) {
                                                      await controller
                                                          .leaveGroup(
                                                              thisGroup);
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        groupActionButtons(
                                            controller, thisGroup),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.symmetric(horizontal: 20),
                                          child: CustomText(
                                            text: "About group".tr,
                                            fontColor: Colors.black,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            textAlignment: Alignment.centerLeft,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        buildGroupAboutSection(),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                      ],
                                    );
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 15,
                                        bottom: 12,
                                        top: 0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.grey.shade300,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: size.width,
                                            height: 0,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: postUserInfo(controller,
                                                postController, index - 1),
                                          ),
                                          SizedBox(height: 10.h,),
                                          postContent(
                                              postController, index - 1),
                                          postImage(postController, index - 1),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: postButtonsAction(
                                                postController, index - 1),
                                          ),
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          postLikesAndCommentsInfo(
                                              postController, index - 1),
                                          SizedBox(
                                            height: 8.h,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: groupPosts.length + 1,
                              )
                            : Column(
                                children: [
                                  Container(
                                    width: size.width,
                                    height: 240.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          thisGroup.groupPictureURL,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          child: CustomText(
                                            text: thisGroup.groupName,
                                            fontWeight: FontWeight.bold,
                                            fontColor: Colors.white,
                                            fontSize: 18.sp,
                                          ),
                                          top: 180.h,
                                          bottom: 35.h,
                                          left: 16.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 25.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.arrow_back_ios_outlined,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              ),
                                              IconButton(
                                                icon: thisGroup.admin ==
                                                        UserModel
                                                            .currentUser.userID
                                                    ? Icon(
                                                        Icons
                                                            .more_vert_outlined,
                                                        color: Colors.white,
                                                      )
                                                    : Container(),
                                                onPressed: thisGroup.admin ==
                                                        UserModel
                                                            .currentUser.userID
                                                    ? () {
                                                        Get.to(
                                                          () =>
                                                              AcceptRefuseView(
                                                            thisGroup:
                                                                thisGroup,
                                                          ),
                                                        );
                                                      }
                                                    : null,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: 180.h,
                                          right: 16.w,
                                          child: CustomButton(
                                            text: thisGroup.admin ==
                                                    UserModel.currentUser.userID
                                                ? "Edit group".tr
                                                : thisGroup.confirmedUsers
                                                        .contains(UserModel
                                                            .currentUser.userID)
                                                    ? "Leave Group".tr
                                                    : thisGroup.unConfirmedUsers
                                                            .contains(UserModel
                                                                .currentUser
                                                                .userID)
                                                        ? "cancel request".tr
                                                        : "Join Group".tr,
                                            buttonFontSize: 14.sp,
                                            buttonHeight: 40.h,
                                            buttonWidth: 104.w,
                                            buttonRadius: 6,
                                            onClick: () async {
                                              if (thisGroup.unConfirmedUsers
                                                      .contains(UserModel
                                                          .currentUser
                                                          .userID) ==
                                                  true) {
                                                await controller
                                                    .cancelRequest(thisGroup);
                                              } else if (thisGroup
                                                          .unConfirmedUsers
                                                          .contains(UserModel
                                                              .currentUser
                                                              .userID) ==
                                                      false &&
                                                  thisGroup.confirmedUsers
                                                          .contains(UserModel
                                                              .currentUser
                                                              .userID) ==
                                                      false &&
                                                  thisGroup.admin !=
                                                      UserModel
                                                          .currentUser.userID) {
                                                await controller
                                                    .joinToGroup(thisGroup);
                                              } else if (thisGroup
                                                          .unConfirmedUsers
                                                          .contains(UserModel
                                                              .currentUser
                                                              .userID) ==
                                                      false &&
                                                  thisGroup.confirmedUsers
                                                      .contains(UserModel
                                                          .currentUser
                                                          .userID) &&
                                                  thisGroup.admin !=
                                                      UserModel
                                                          .currentUser.userID) {
                                                await controller
                                                    .leaveGroup(thisGroup);
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  groupActionButtons(controller, thisGroup),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: CustomText(
                                      text: "About group".tr,
                                      fontColor: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      textAlignment: Alignment.centerLeft,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  buildGroupAboutSection(),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: CustomText(
                                        text: "noPosts".tr,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  )
                                ],
                              );
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Padding postLikesAndCommentsInfo(PostsViewModel postController, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          CustomText(
            text: groupPosts[index].likes.length.toString() + " Likes".tr,
            fontSize: 14,
            fontColor: Colors.grey,
          ),
          SizedBox(
            width: 8.w,
          ),
          CustomText(
            text: (groupPosts[index].comments != null)
                ? groupPosts[index].comments.length.toString() + " Comments".tr
                : "0 Comments".tr,
            fontSize: 14,
            fontColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Row postButtonsAction(PostsViewModel postController, int index) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            if (thisGroup.confirmedUsers
                .contains(UserModel.currentUser.userID)) {
              if (groupPosts[index]
                  .likes
                  .contains(UserModel.currentUser.userID)) {
                postController.removeLike(groupPosts[index]);
                await postController.getAllPostsByUserId();
              } else {
                postController.addLike(groupPosts[index]);
                await postController.getAllPostsByUserId();
              }
            } else {
              Get.defaultDialog(
                  radius: 12,
                  title: "Request Not Valid".tr,
                  middleText: "Please join to the group".tr);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.favorite_border_outlined,
              size: 30.w,
              color:
                  groupPosts[index].likes.contains(UserModel.currentUser.userID)
                      ? Colors.red
                      : Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: () async {
            if (thisGroup.confirmedUsers
                .contains(UserModel.currentUser.userID)) {
              await postController
                  .getPostCommentsFromFireStore(groupPosts[index].postId);
              Get.to(() => CommentView(
                    thisGroup: thisGroup,
                    thePost: groupPosts[index],
                    postId: groupPosts[index].postId,
                  ));
            } else {
              Get.defaultDialog(
                  radius: 12,
                  title: "Request Not Valid".tr,
                  middleText: "Please join to the group".tr);
            }
          },
          child: Container(
            child: Image(
              image: ExactAssetImage("assets/images/commentIcon.png"),
              //sss width: 35.w,
              height: 35.w,
            ),
          ),
        )
      ],
    );
  }

  ConstrainedBox postImage(PostsViewModel postController, int index) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 10.h, minWidth: 370.w),
      child: groupPosts[index].postImageURL != null
          ? Image(image: NetworkImage(groupPosts[index].postImageURL))
          : Container(),
    );
  }

  LayoutBuilder postContent(PostsViewModel postController, int index) {
    return LayoutBuilder(
      builder: (context, constrain) {
        if (groupPosts[index].postContent != "") {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CustomText(
              text: groupPosts[index].postContent,
              textAlignment: Alignment.centerLeft,
              fontSize: 16.sp,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget postUserInfo(
      GroupViewModel controller, PostsViewModel postController, int index) {
    try {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      controller.getUser(groupPosts[index].userId).picURL),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: thisGroup.groupName,
                      fontSize: 14.sp,
                    ),
                    CustomText(
                      text: controller.getUser(groupPosts[index].userId).userName,
                      fontSize: 14.sp,
                      fontColor: Colors.grey,
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                GestureDetector(
                  child: groupPosts[index].userId == UserModel.currentUser.userID ?Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ) : Container(),
                  onTap: () {
                    if(groupPosts[index].userId == UserModel.currentUser.userID)
                      {
                        Get.to(EditPostView(thisGroup: thisGroup,thePost: groupPosts[index],));
                      }
                  },
                ),
                SizedBox(width: 15.w,),
                GestureDetector(
                  child:
                      groupPosts[index].userId == UserModel.currentUser.userID ||
                              UserModel.currentUser.userID == thisGroup.admin
                          ? Icon(
                              Icons.delete_outline,
                              color: Colors.grey,
                            )
                          : Container(),
                           onTap: () async {
                          if (groupPosts[index].userId ==
                                  UserModel.currentUser.userID ||
                              UserModel.currentUser.userID == thisGroup.admin) {
                            await postController.deletePost(groupPosts[index].postId);
                          }
                        },
                ),
              ],
            ),
          )
        ],
      );
    } catch (e) {
      return CircularProgressIndicator();
    }
  }

  Padding buildGroupAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomText(
        text: thisGroup.groupDescription,
        fontColor: Color(0xff9A9595),
        fontSize: 16.sp,
        textAlignment: Alignment.centerLeft,
      ),
    );
  }

  Padding groupActionButtons(GroupViewModel controller, GroupModel group) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              if (thisGroup.confirmedUsers
                  .contains(UserModel.currentUser.userID)) {
                Get.bottomSheet(
                  Container(
                    color: Colors.white,
                    height: 400.h,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16.w,
                                    backgroundImage: NetworkImage(controller
                                        .getUser(group.confirmedUsers[index])
                                        .picURL),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: controller
                                            .getUser(
                                                group.confirmedUsers[index])
                                            .userName,
                                        fontSize: 16.sp,
                                      ),
                                      CustomText(
                                        text: thisGroup.admin ==
                                                thisGroup.confirmedUsers[index]
                                            ? "admin".tr
                                            : "Member".tr,
                                        fontSize: 14.sp,
                                        fontColor: Colors.grey.shade500,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            )
                          ],
                        );
                      },
                      itemCount: group.confirmedUsers.length,
                    ),
                  ),
                );
              } else {
                Get.defaultDialog(
                    title: "Request Not Valid".tr,
                    radius: 12,
                    middleText: "Please join to the group tp up Posts".tr);
              }
            },
            child: Container(
              width: 106.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Image.asset("assets/images/component1.png"),
                  CustomText(
                    text: "Members".tr,
                    fontSize: 12.sp,
                    fontColor: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (thisGroup.confirmedUsers
                  .contains(UserModel.currentUser.userID)) {
                Get.to(() => MessageView(
                      group: group,
                    ));
              } else {
                Get.defaultDialog(
                    title: "Request Not Valid".tr,
                    radius: 12,
                    middleText: "Please join to the group to Starting Chat".tr);
              }
            },
            child: Container(
              width: 106.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/mess.png",
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                    text: "Message".tr,
                    fontSize: 12.sp,
                    fontColor: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (thisGroup.confirmedUsers
                  .contains(UserModel.currentUser.userID)) {
                Get.to(
                  () => CreatePostView(
                    groupId: thisGroup.groupID,
                    groupAdminId: thisGroup.admin,
                    thisGroup: thisGroup,
                  ),
                );
              } else {
                Get.defaultDialog(
                    title: "Request Not Valid".tr,
                    radius: 12,
                    middleText: "Please join to the group tp up Posts".tr);
              }
            },
            child: Container(
              width: 106.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Color(0xffE6E6E6),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/up.png",
                    width: 20.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  CustomText(
                    text: "Post".tr,
                    fontSize: 12.sp,
                    fontColor: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
