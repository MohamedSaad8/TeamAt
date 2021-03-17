import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/view/comment_view.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: GetBuilder<PostsViewModel>(
        init: PostsViewModel(),
        builder: (postController) => postController.userPosts.isNotEmpty &&
                postController.userPosts.length > 0
            ? ListView.builder(
                itemBuilder: (context, index) {
                  if (index == 0) {
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
                                      UserModel.currentUser.picURL),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.settings,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: GetBuilder<AuthViewModel>(
                                  init: AuthViewModel(),
                                  builder: (controller) => IconButton(
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
                          text: UserModel.currentUser.userName,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            height: 65.h,
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    CustomText(
                                      text: postController.userPosts.length
                                          .toString(),
                                      fontSize: 16.sp,
                                      fontColor: kSecondColor,
                                    ),
                                    CustomText(
                                      text: "Posts",
                                      fontSize: 16.sp,
                                      fontColor: kSecondColor,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomText(
                                      text: postController.myGroups.toString(),
                                      fontSize: 16.sp,
                                      fontColor: Colors.black,
                                    ),
                                    CustomText(
                                      text: "My groups",
                                      fontSize: 16.sp,
                                      fontColor: Colors.grey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    CustomText(
                                      text: postController.followingGroups
                                          .toString(),
                                      fontSize: 16.sp,
                                      fontColor: Colors.black,
                                    ),
                                    CustomText(
                                      text: "Following groups",
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomText(
                            text: "My Bio",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            textAlignment: Alignment.topLeft,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomText(
                            text: UserModel.currentUser.name,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            textAlignment: Alignment.topLeft,
                          ),
                        ),
                        SizedBox(height: 24.h,)
                      ],
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 12, top: 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: postController
                                          .getGroup(postController
                                              .userPosts[index - 1].groupId)
                                          .groupName,
                                      fontSize: 14.sp,
                                    ),
                                    CustomText(
                                      text: UserModel.currentUser.userName,
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
                              if (postController
                                      .userPosts[index - 1].postContent !=
                                  "") {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: CustomText(
                                    text: postController
                                        .userPosts[index - 1].postContent,
                                    textAlignment: Alignment.centerLeft,
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
                            child: postController
                                        .userPosts[index - 1].postImageURL !=
                                    null
                                ? Image(
                                    image: NetworkImage(postController
                                        .userPosts[index - 1].postImageURL))
                                : Container(),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (postController.userPosts[index - 1].likes
                                      .contains(UserModel.currentUser.userID))
                                    postController.removeLike(
                                        postController.userPosts[index - 1]);
                                  else
                                    postController.addLike(
                                        postController.userPosts[index - 1]);
                                },
                                child: Icon(
                                  Icons.favorite_border_outlined,
                                  size: 30.w,
                                  color: postController
                                          .userPosts[index - 1].likes
                                          .contains(
                                              UserModel.currentUser.userID)
                                      ? Colors.red
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await postController
                                      .getPostCommentsFromFireStore(
                                          postController
                                              .userPosts[index - 1].postId);

                                  Get.to(() => CommentView(
                                        thisGroup: postController.getGroup(
                                            postController
                                                .userPosts[index - 1].groupId),
                                        thePost:
                                            postController.userPosts[index - 1],
                                        postId: postController
                                            .userPosts[index - 1].postId,
                                      ));

                                  // Get.to(() => CommentViewFromProfile(
                                  //   postComments : postController.postComments,
                                  //   thisGroup: postController.getGroup(postController.userPosts[index -1 ].groupId) ,
                                  //   thePost: postController.userPosts[index -1 ] ,
                                  //   postId:postController.userPosts[index -1 ].postId ,
                                  // ));
                                },
                                child: Icon(
                                  Icons.messenger_outline,
                                  size: 25.w,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                CustomText(
                                  text: postController
                                          .userPosts[index - 1].likes.length
                                          .toString() +
                                      " Likes",
                                  fontSize: 14,
                                  fontColor: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                CustomText(
                                  text: (postController.userPosts[index - 1]
                                                  .comments !=
                                              null &&
                                          postController.userPosts[index - 1]
                                                  .comments.length >
                                              0)
                                      ? postController.userPosts[index - 1]
                                              .comments.length
                                              .toString() +
                                          " Comments"
                                      : "0 Comments",
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
                },
                itemCount: postController.userPosts.length + 1,
              )
            : Column(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),
                  Container(
                    width: size.width,
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 60.w,
                            backgroundImage:
                                NetworkImage(UserModel.currentUser.picURL),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.settings,
                              color: Colors.grey,
                            ),
                            onPressed: () async {},
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: GetBuilder<AuthViewModel>(
                            init: AuthViewModel(),
                            builder: (controller) => IconButton(
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
                    text: UserModel.currentUser.userName,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 50.h,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CustomText(
                                text: "48",
                                fontSize: 16.sp,
                                fontColor: kSecondColor,
                              ),
                              CustomText(
                                text: "Posts",
                                fontSize: 16.sp,
                                fontColor: kSecondColor,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              CustomText(
                                text: "10",
                                fontSize: 16.sp,
                                fontColor: Colors.black,
                              ),
                              CustomText(
                                text: "My groups",
                                fontSize: 16.sp,
                                fontColor: Colors.grey,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              CustomText(
                                text: "10",
                                fontSize: 16.sp,
                                fontColor: Colors.black,
                              ),
                              CustomText(
                                text: "Following groups",
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text: "My Bio",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      textAlignment: Alignment.topLeft,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText(
                      text: UserModel.currentUser.name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      textAlignment: Alignment.topLeft,
                    ),
                  ),
                  SizedBox(height: 24.h,),
                  Expanded(
                    child: Center(
                      child: CustomText(
                        text: "No Posts Tell Now",
                        fontColor: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
