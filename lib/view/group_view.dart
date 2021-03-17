import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/comment_model.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/message_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/view/message_view.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:get/get.dart';
import 'package:team_at/view/accept_refuse_view.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/view/create_post_view.dart';
import 'package:uuid/uuid.dart';
import 'package:team_at/view/comment_view.dart';

class GroupView extends StatelessWidget {
  final GroupModel thisGroup;

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
                builder: (postController) => postController
                            .groupPosts.isNotEmpty &&
                        postController.groupPosts.length > 0
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
                                                      Icons.more_vert_outlined,
                                                      color: Colors.white,
                                                    )
                                                  : Container(),
                                              onPressed: thisGroup.admin ==
                                                      UserModel
                                                          .currentUser.userID
                                                  ? () {
                                                      Get.to(
                                                        () => AcceptRefuseView(
                                                          thisGroup: thisGroup,
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
                                              ? "Edit group"
                                              : thisGroup.confirmedUsers
                                                      .contains(UserModel
                                                          .currentUser.userID)
                                                  ? "Leave Group"
                                                  : thisGroup.unConfirmedUsers
                                                          .contains(UserModel
                                                              .currentUser
                                                              .userID)
                                                      ? "cancel request"
                                                      : "Join Group",
                                          buttonFontSize: 14,
                                          buttonHeight: 40.h,
                                          buttonWidth: 104.w,
                                          buttonRadius: 6,
                                          onClick: () async {
                                            if (thisGroup.unConfirmedUsers
                                                    .contains(UserModel
                                                        .currentUser.userID) ==
                                                true) {
                                              await controller
                                                  .cancelRequest(thisGroup);
                                              print("from one");
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
                                              print("from two");
                                            } else if (thisGroup
                                                        .unConfirmedUsers
                                                        .contains(UserModel
                                                            .currentUser
                                                            .userID) ==
                                                    false &&
                                                thisGroup.confirmedUsers
                                                    .contains(UserModel
                                                        .currentUser.userID) &&
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
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CustomText(
                                    text: "About group",
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
                                left: 15, right: 15, bottom: 12, top: 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300 ,width: 1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: size.width,
                                    height: 0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: postUserInfo(
                                        controller, postController, index - 1),
                                  ),
                                  postContent(postController, index - 1),
                                  postImage(postController, index - 1),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
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
                        itemCount: postController.groupPosts.length + 1,
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
                                  padding: EdgeInsets.only(top: 40.h),
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
                                                UserModel.currentUser.userID
                                            ? Icon(
                                                Icons.more_vert_outlined,
                                                color: Colors.white,
                                              )
                                            : Container(),
                                        onPressed: thisGroup.admin ==
                                                UserModel.currentUser.userID
                                            ? () {
                                                Get.to(
                                                  () => AcceptRefuseView(
                                                    thisGroup: thisGroup,
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
                                        ? "Edit group"
                                        : thisGroup.confirmedUsers.contains(
                                                UserModel.currentUser.userID)
                                            ? "Leave Group"
                                            : thisGroup.unConfirmedUsers
                                                    .contains(UserModel
                                                        .currentUser.userID)
                                                ? "cancel request"
                                                : "Join Group",
                                    buttonFontSize: 14,
                                    buttonHeight: 40.h,
                                    buttonWidth: 104.w,
                                    buttonRadius: 6,
                                    onClick: () async {
                                      if (thisGroup.unConfirmedUsers.contains(
                                              UserModel.currentUser.userID) ==
                                          true) {
                                        await controller
                                            .cancelRequest(thisGroup);
                                        print("from one");
                                      } else if (thisGroup.unConfirmedUsers
                                                  .contains(UserModel
                                                      .currentUser.userID) ==
                                              false &&
                                          thisGroup.confirmedUsers.contains(
                                                  UserModel
                                                      .currentUser.userID) ==
                                              false &&
                                          thisGroup.admin !=
                                              UserModel.currentUser.userID) {
                                        await controller.joinToGroup(thisGroup);
                                        print("from two");
                                      } else if (thisGroup.unConfirmedUsers
                                                  .contains(UserModel
                                                      .currentUser.userID) ==
                                              false &&
                                          thisGroup.confirmedUsers.contains(
                                              UserModel.currentUser.userID) &&
                                          thisGroup.admin !=
                                              UserModel.currentUser.userID) {
                                        await controller.leaveGroup(thisGroup);
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
                            padding: const EdgeInsets.only(left: 20),
                            child: CustomText(
                              text: "About group",
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
                                text: "No posts in this group till now",
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                fontColor: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding postLikesAndCommentsInfo(PostsViewModel postController, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          CustomText(
            text: postController.groupPosts[index].likes.length.toString() +
                " Likes",
            fontSize: 14,
            fontColor: Colors.grey,
          ),
          SizedBox(
            width: 8.w,
          ),
          CustomText(
            text: (postController.groupPosts[index].comments != null)
                ? postController.groupPosts[index].comments.length.toString() +
                    " Comments"
                : "0 Comments",
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
              if (postController.groupPosts[index].likes
                  .contains(UserModel.currentUser.userID)) {
                postController.removeLike(postController.groupPosts[index]);
                await postController.getAllPostsByUserId();
              } else {
                postController.addLike(postController.groupPosts[index]);
                await postController.getAllPostsByUserId();
              }
            } else {
              Get.defaultDialog(
                  title: "Request Not Valid",
                  middleText: "Please join to the group");
            }
          },
          child: Icon(
            Icons.favorite_border_outlined,
            size: 30.w,
            color: postController.groupPosts[index].likes
                    .contains(UserModel.currentUser.userID)
                ? Colors.red
                : Colors.black,
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: () async {
            await postController.getPostCommentsFromFireStore(
                postController.groupPosts[index].postId);
            Get.to(() => CommentView(
                  thisGroup: thisGroup,
                  thePost: postController.groupPosts[index],
                  postId: postController.groupPosts[index].postId,
                ));
          },
          child: Icon(
            Icons.messenger_outline,
            size: 25.w,
          ),
        )
      ],
    );
  }

  ConstrainedBox postImage(PostsViewModel postController, int index) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 10.h, minWidth: 370.w),
      child: postController.groupPosts[index].postImageURL != null
          ? Image(
              image:
                  NetworkImage(postController.groupPosts[index].postImageURL))
          : Container(),
    );
  }

  LayoutBuilder postContent(PostsViewModel postController, int index) {
    return LayoutBuilder(
      builder: (context, constrain) {
        if (postController.groupPosts[index].postContent != "") {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: CustomText(
              text: postController.groupPosts[index].postContent,
              textAlignment: Alignment.centerLeft,
              fontSize: 16.sp,
            ),
          );
        }
        return Container();
      },
    );
  }

  Row postUserInfo(
      GroupViewModel controller, PostsViewModel postController, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(controller
                  .getUser(postController.groupPosts[index].userId)
                  .picURL),
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
                  text: controller
                      .getUser(postController.groupPosts[index].userId)
                      .userName,
                  fontSize: 14.sp,
                  fontColor: Colors.grey,
                ),
              ],
            )
          ],
        ),
        IconButton(
          icon: Icon(
            Icons.more_vert_outlined,
            color: Colors.grey,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Padding buildGroupAboutSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
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
                                            ? "admin"
                                            : "Member",
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
                    title: "Request Not Valid",
                    radius: 12,
                    middleText: "Please join to the group tp up Posts");
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
                    text: "Members",
                    fontSize: 12.sp,
                    fontColor: Colors.grey.shade500,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
             Get.to(() => MessageView(group: group,));
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
                    text: "Message",
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
                    title: "Request Not Valid",
                    radius: 12,
                    middleText: "Please join to the group tp up Posts");
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
                    text: "Post",
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
