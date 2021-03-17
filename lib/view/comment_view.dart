import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/comment_model.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/post_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommentView extends StatelessWidget {
  //final int index;
  final GroupModel thisGroup;
  final postId;

  final PostModel thePost;

  CommentView({this.thisGroup, this.postId, this.thePost});

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsViewModel>(
      init: PostsViewModel(),
      builder: (postController) => Scaffold(
        backgroundColor: Colors.grey.shade500,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: SafeArea(
            child: Form(
              key: _key,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
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
                      CustomText(
                        text: "Comments",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontColor: Colors.black,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Expanded(
                    child: postController.postComments.length > 0
                        ? ListView.builder(
                            itemBuilder: (context, position) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16.w,
                                          backgroundImage: NetworkImage(
                                              postController
                                                  .getUser(postController
                                                      .postComments[position]
                                                      .userId)
                                                  .picURL),
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
                                                  .getUser(postController
                                                      .postComments[position]
                                                      .userId)
                                                  .userName,
                                              fontSize: 16.sp,
                                              fontColor: Colors.black,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, bottom: 5),
                                        child: CustomText(
                                          textAlignment: Alignment.centerLeft,
                                          text: postController
                                              .postComments[position]
                                              .commentContent,
                                          fontColor: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      height: 4,
                                      thickness: 0.5,
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: postController.postComments.length,

                            ///String comments ids
                          )
                        : InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 30,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "view all comments",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () async {
                              postController
                                  .getPostCommentsFromFireStore(postId);
                            },
                          ),
                  ),
                  TextFormField(
                    controller: _controller,
                    maxLines: null,
                    onSaved: (val) {
                      postController.commentContent = val;
                    },
                    validator: (val) {
                      if (val.isEmpty)
                        Get.snackbar("Comment Error", "Please Enter Comment");
                    },
                    decoration: InputDecoration(
                      hintText: "Write a comment",
                      contentPadding: EdgeInsets.only(left: 10, top: 15),
                      suffixIcon: GestureDetector(
                          onTap: () async {
                            if (_key.currentState.validate()) {
                              _key.currentState.save();
                              await postController.createComment(
                                  groupId: thisGroup.groupID,
                                  comment: CommentModel(
                                      userId: UserModel.currentUser.userID,
                                      postId: postId,
                                      commentContent:
                                          postController.commentContent,
                                      commentId: Uuid().v4()),
                                  post: thePost);
                              _controller.clear();
                              await postController.getAllPostsByUserId();
                              await postController
                                  .getPostCommentsFromFireStore(postId);
                              // await postController.getPostCommentsFromFireStore(postController.groupPosts[index].postId);
                            }
                          },
                          child: Icon(
                            Icons.send_outlined,
                            color: kSecondColor,
                          )),
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
