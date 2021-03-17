import 'package:flutter/material.dart';
import 'package:team_at/model/user_model.dart';
import 'package:get/get.dart';
import 'package:team_at/view/comment_view.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<PostsViewModel>(
          init: PostsViewModel(),
          builder: (postController) => Column(
            children: [
              SizedBox(height: 50.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: 42.h,
                        width: 42.h,
                        child: Icon(Icons.location_on_outlined),
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 42.h,
                        width: 290.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(text: "Search for Group") ,
                            Icon(Icons.search),
                          ],
                        ),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Expanded(
                child:postController.followingGroupsPosts.length > 0 ? ListView.builder(
                      itemCount: postController.followingGroupsPosts.length,
                      itemBuilder: (context, index) => Padding(
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
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage:
                                          NetworkImage(postController.getUser(postController.followingGroupsPosts[index].userId).picURL),
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
                                                  .followingGroupsPosts[index]
                                                  .groupId)
                                              .groupName,
                                          fontSize: 14.sp,
                                        ),
                                        CustomText(
                                          text:postController.getUser(postController.followingGroupsPosts[index].userId).userName,
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
                                          .followingGroupsPosts[index].postContent !=
                                      "") {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: CustomText(
                                        text: postController
                                            .followingGroupsPosts[index].postContent,
                                        textAlignment: Alignment.centerLeft,
                                        fontSize: 16.sp,
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(minHeight: 10.h, minWidth: 370.w),
                                child: postController.followingGroupsPosts[index]
                                            .postImageURL !=
                                        null
                                    ? Image(
                                        image: NetworkImage(postController
                                            .followingGroupsPosts[index]
                                            .postImageURL))
                                    : Container(),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (postController
                                          .followingGroupsPosts[index].likes
                                          .contains(UserModel.currentUser.userID))
                                        postController.removeLike(postController
                                            .followingGroupsPosts[index]);
                                      else
                                        postController.addLike(postController
                                            .followingGroupsPosts[index]);
                                    },
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 30.w,
                                      color: postController
                                              .followingGroupsPosts[index].likes
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
                                      await postController
                                          .getPostCommentsFromFireStore(postController
                                              .followingGroupsPosts[index].postId);

                                      Get.to(() => CommentView(
                                            thisGroup: postController.getGroup(
                                                postController
                                                    .followingGroupsPosts[index]
                                                    .groupId),
                                            thePost: postController
                                                .followingGroupsPosts[index],
                                            postId: postController
                                                .followingGroupsPosts[index].postId,
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
                                      text: postController.followingGroupsPosts[index]
                                              .likes.length
                                              .toString() +
                                          " Likes",
                                      fontSize: 14,
                                      fontColor: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    CustomText(
                                      text: (postController
                                                      .followingGroupsPosts[index]
                                                      .comments !=
                                                  null &&
                                              postController.followingGroupsPosts[index].comments
                                                      .length >
                                                  0)
                                          ? postController.followingGroupsPosts[index]
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
                      ),
                    ) :
                Center(child: CustomText(text: "Time Line is empty",),)
                ,
              ),
            ],
          )),
    );
  }
}
