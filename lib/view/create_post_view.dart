import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/post_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:team_at/view/group_view.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:uuid/uuid.dart';

class CreatePostView extends StatelessWidget {
  final String groupId;
  final String groupAdminId;
  final GroupModel thisGroup;

  final _controller = TextEditingController();

  CreatePostView({this.groupId, this.groupAdminId, this.thisGroup});

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GetBuilder<PostsViewModel>(
        init: PostsViewModel(),
        builder: (controller) => ModalProgressHUD(
          inAsyncCall: controller.isLoading,
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                          text: "Create Post".tr,
                          fontSize: 18.sp,
                          fontColor: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: CustomButton(
                        text: "Post".tr,
                        buttonRadius: 6,
                        buttonWidth: 105.w,
                        buttonHeight: 32.h,
                        buttonFontSize: 14,
                        onClick: () async {
                          _key.currentState.save();
                          if (controller.postImage == null &&
                              controller.postContent == "") {
                            Get.snackbar("postError", "Set A Post At First",
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            controller.changeIsLoading(true);
                            if (controller.postImage != null) {
                              await controller.uploadImage();
                            }
                            await controller.createPost(
                                PostModel(
                                  groupId: groupId,
                                  likes: [],
                                  comments: [],
                                  postContent: controller.postContent,
                                  postImageURL: controller.postImageURL,
                                  userId: UserModel.currentUser.userID,
                                  postId: Uuid().v4(),
                                ),
                                groupId);
                            controller.changeIsLoading(false);
                            _controller.clear();
                            controller.setImageEqualNull();
                            Get.to(() => GroupView(
                                  thisGroup: thisGroup,
                                ));
                          }
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16.w,
                        backgroundImage:
                            NetworkImage(UserModel.currentUser.picURL),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: UserModel.currentUser.userName,
                            fontSize: 16.sp,
                            fontColor: Colors.black,
                          ),
                          CustomText(
                            text: groupAdminId == UserModel.currentUser.userID
                                ? "admin of group".tr
                                : "member in group".tr,
                            fontSize: 14.sp,
                            fontColor: Color(0xff9A9595),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "What\'s in your mind ?".tr,
                          hintStyle: TextStyle(
                            color: Color(0xff9A9595),
                            fontSize: 24.sp,
                          ),
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                        controller: _controller,
                        maxLines: null,
                        onSaved: (val) {
                          controller.postContent = val;
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      getImageButtons(controller),
                      SizedBox(
                        height: 8.h,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: 370.h, minWidth: 370.w),
                        child: controller.postImage != null
                            ? Image(image: FileImage(controller.postImage))
                            : Container(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row getImageButtons(PostsViewModel controller) {
    return Row(
      children: [
        SizedBox(
          width: 16.w,
        ),
        InkWell(
          onTap: () async {
            await controller.getPostImageFromGCamera();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffD6D9DE),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 96.w,
            height: 32.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
                CustomText(
                  text: "Camera".tr,
                  fontColor: Colors.black,
                  fontSize: 12,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: 24.w,
        ),
        InkWell(
          onTap: () async {
            await controller.getPostImageFromGallery();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffD6D9DE),
              borderRadius: BorderRadius.circular(12),
            ),
            width: 96.w,
            height: 32.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.photo,
                  color: Colors.black,
                ),
                CustomText(
                  text: "Photos".tr,
                  fontColor: Colors.black,
                  fontSize: 12,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
