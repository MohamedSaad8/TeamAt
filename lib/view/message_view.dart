import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/model/group_model.dart';
import 'package:team_at/model/message_model.dart';
import 'package:team_at/model/user_model.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:team_at/widget/custom_text.dart';


class MessageView extends StatelessWidget {
  final GroupModel group;

  MessageView({this.group});

  List<MessageModel> groupMessages = [];
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  String messageContent;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroupViewModel>(
      init: GroupViewModel(),
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
                        text: group.groupName + " Chat",
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: postController.getMessageFromGroupMessages(group),
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          groupMessages.clear();
                          scrollController.jumpTo(scrollController.position.maxScrollExtent+50);
                          for (var doc in snapShot.data.docs) {
                            var data = doc.data();
                            groupMessages.add(MessageModel.fromJson(data));
                          }
                        }

                        return ListView.builder(
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Directionality(
                                textDirection: groupMessages[index].senderId ==
                                        UserModel.currentUser.userID
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 16.w,
                                        backgroundImage: NetworkImage(postController
                                            .getUser(groupMessages[index].senderId)
                                            .picURL),
                                      ),
                                      SizedBox(width: 10.w,),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            minWidth: 0.w, maxWidth: 200.w),
                                        child: Container(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: groupMessages[index].senderId ==
                                                    UserModel.currentUser.userID
                                                ? Colors.green
                                                : Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            groupMessages[index].messageContent,
                                            softWrap: true,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontFamily: "Cairo",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: groupMessages.length,
                        );
                      },
                    ),
                  ),
                  TextFormField(
                    controller: _controller,
                    maxLines: null,
                    onSaved: (val) {
                      messageContent = val;
                    },
                    decoration: InputDecoration(
                      hintText: "Write a message",
                      contentPadding: EdgeInsets.only(left: 10, top: 15),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          _key.currentState.save();
                          await postController.addMessageInGroupMessages(
                              group,
                              MessageModel(
                                  senderId: UserModel.currentUser.userID,
                                  groupId: group.groupID,
                                  messageId: groupMessages.length,
                                  messageContent: messageContent));
                          _controller.clear();
                        },
                        child: Icon(
                          Icons.send_outlined,
                          color: kSecondColor,
                        ),
                      ),
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
