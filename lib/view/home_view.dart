import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:team_at/model/post_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:get/get.dart';
import 'package:team_at/servcies/firestore_groups.dart';
import 'package:team_at/view/comment_view.dart';
import 'package:team_at/view/map_view.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/widget/data_search.dart';

class HomeView extends StatelessWidget {
  List<PostModel> followingGroupsPosts = [] ;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<PostsViewModel>(
        init: PostsViewModel(),
        builder: (postController) => ModalProgressHUD(
          inAsyncCall: postController.isLoading,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        postController.changeIsLoading(true);
                        var markersIconBytes = [] ;
                        var snapShot = await FireStoreGroups().groupCollectionRef.get();
                        for (var doc in snapShot.docs) {
                          var data = doc.data();
                          markersIconBytes.add(await postController.getMarkerIcon(
                            markerSize: 100,
                            url: data["groupPictureURL"]
                          ));

                        }

                        postController.changeIsLoading(false);

                        Get.to(() => MapView(markersIconBytes));
                      },
                      child: Container(
                        height: 42.h,
                        width: 42.h,
                        child: Icon(Icons.location_on_outlined),
                        color: Colors.grey.shade300,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GetBuilder<GroupViewModel>(
                      init: GroupViewModel(),
                      builder: (searchController) => InkWell(
                        onTap: () {
                          showSearch(
                              context: context,
                              delegate: DataSearch(
                                  allGroups: searchController.allGroups));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 42.h,
                          width: 290.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(text: "Search for Group".tr),
                              Icon(Icons.search),
                            ],
                          ),
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: postController.getTimeLinePosts() ,
                builder: (context , snapShot){

                  followingGroupsPosts.clear();
                  try{
                    for (var doc in snapShot.data.docs) {
                      var data = doc.data();
                      if (postController.getGroup(data["groupId"]).confirmedUsers.contains(UserModel.currentUser.userID)) {
                        followingGroupsPosts.add(PostModel.fromJson(data));
                      }
                    }
                  }catch(e){
                    followingGroupsPosts = [];
                  }
                  return  Expanded(
                    child: followingGroupsPosts.length > 0
                        ? ListView.builder(
                      itemCount: followingGroupsPosts.length,
                      itemBuilder: (context, index) => Padding(
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
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundImage: NetworkImage(
                                          postController
                                              .getUser(followingGroupsPosts[index]
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
                                              .getGroup(followingGroupsPosts[index]
                                              .groupId)
                                              .groupName,
                                          fontSize: 14.sp,
                                        ),
                                        CustomText(
                                          text: postController
                                              .getUser(followingGroupsPosts[index]
                                              .userId)
                                              .userName,
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
                                  if (followingGroupsPosts[index]
                                      .postContent !=
                                      "") {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: CustomText(
                                        text:followingGroupsPosts[index]
                                            .postContent,
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
                                child: followingGroupsPosts[index]
                                    .postImageURL !=
                                    null
                                    ? Image(
                                    image: NetworkImage(followingGroupsPosts[index]
                                        .postImageURL))
                                    : Container(),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      if (followingGroupsPosts[index].likes
                                          .contains(
                                          UserModel.currentUser.userID))
                                        postController.removeLike(followingGroupsPosts[index]);
                                      else
                                        postController.addLike(followingGroupsPosts[index]);
                                    },
                                    child: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 30.w,
                                      color: followingGroupsPosts[index].likes
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
                                          followingGroupsPosts[index]
                                              .postId);

                                      Get.to(
                                            () => CommentView(
                                          thisGroup: postController.getGroup(
                                              followingGroupsPosts[index]
                                                  .groupId),
                                          thePost: followingGroupsPosts[index],
                                          postId: followingGroupsPosts[index]
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
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    CustomText(
                                      text: followingGroupsPosts[index]
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
                                      text: (followingGroupsPosts[
                                      index]
                                          .comments !=
                                          null &&
                                          followingGroupsPosts[
                                          index]
                                              .comments
                                              .length >
                                              0)
                                          ? followingGroupsPosts[index]
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
                      ),
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Time Line is empty".tr,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Searching For Posts".tr,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            CircularProgressIndicator(strokeWidth: 2)
                          ],
                        ),
                      ],
                    ),
                  ) ;
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
