import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/view/AuthonticationScreens/login_view.dart';
import 'package:team_at/view/create_post_view.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';
import 'package:team_at/viewModel/controlHomeViewModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/viewModel/group_view_model.dart';
import 'package:team_at/widget/custom_text.dart';

class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetX<AuthViewModel>(
      init: AuthViewModel(),
      builder: (cont){
        return (cont.userEmail == null)
            ? LoginView()
            : GetBuilder<ControlHomeViewModel>(
          init: ControlHomeViewModel(),
          builder: (controller) => Scaffold(
            body: controller.currentScreen,
            bottomNavigationBar: _bottomNavigationBar(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: kMainColor,
              onPressed: () {
                Get.bottomSheet(
                  GetBuilder<GroupViewModel>(
                    init: GroupViewModel(),
                    builder: (groupController) => Container(
                      height: 600.h,
                      width: 375.w,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomText(
                              text: "Select Group".tr,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              textAlignment: Alignment.centerLeft,
                            ),
                            Divider(color: Colors.grey,),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: (){
                                      Get.to(()=> CreatePostView(
                                        groupAdminId: groupController.myGroupsList[index].admin,
                                        groupId: groupController.myGroupsList[index].groupID ,
                                        thisGroup: groupController.myGroupsList[index] ,
                                      ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16.w,
                                            backgroundImage: NetworkImage(
                                                groupController
                                                    .myGroupsList[index]
                                                    .groupPictureURL),
                                          ),
                                          SizedBox(
                                            width: 8.w,
                                          ),
                                          CustomText(
                                            text: groupController
                                                .myGroupsList[index].groupName,
                                            fontSize: 16.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: groupController.myGroupsList.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
          ),
        );
      },
    );

    // return Obx(
    //   () {
    //     return (Get.find<AuthViewModel>().userEmail == null)
    //         ? LoginView()
    //         : GetBuilder<ControlHomeViewModel>(
    //             init: ControlHomeViewModel(),
    //             builder: (controller) => Scaffold(
    //               body: controller.currentScreen,
    //               bottomNavigationBar: _bottomNavigationBar(),
    //               floatingActionButton: FloatingActionButton(
    //                 backgroundColor: kMainColor,
    //                 onPressed: () {
    //                   Get.bottomSheet(
    //                     GetBuilder<GroupViewModel>(
    //                       init: GroupViewModel(),
    //                       builder: (groupController) => Container(
    //                         height: 600.h,
    //                         width: 375.w,
    //                         color: Colors.white,
    //                         child: Padding(
    //                           padding: const EdgeInsets.symmetric(horizontal: 10),
    //                           child: Column(
    //                             children: [
    //                               SizedBox(
    //                                 height: 10.h,
    //                               ),
    //                               CustomText(
    //                                 text: "Select Group",
    //                                 fontSize: 18.sp,
    //                                 fontWeight: FontWeight.bold,
    //                                 textAlignment: Alignment.centerLeft,
    //                               ),
    //                               Divider(color: Colors.grey,),
    //                               Expanded(
    //                                 child: ListView.builder(
    //                                   itemBuilder: (context, index) {
    //                                     return InkWell(
    //                                       onTap: (){
    //                                         Get.to(()=> CreatePostView(
    //                                           groupAdminId: groupController.myGroupsList[index].admin,
    //                                           groupId: groupController.myGroupsList[index].groupID ,
    //                                           thisGroup: groupController.myGroupsList[index] ,
    //                                         ),
    //                                         );
    //                                       },
    //                                       child: Padding(
    //                                         padding: const EdgeInsets.only(bottom: 10),
    //                                         child: Row(
    //                                           children: [
    //                                             CircleAvatar(
    //                                               radius: 16.w,
    //                                               backgroundImage: NetworkImage(
    //                                                   groupController
    //                                                       .myGroupsList[index]
    //                                                       .groupPictureURL),
    //                                             ),
    //                                             SizedBox(
    //                                               width: 8.w,
    //                                             ),
    //                                             CustomText(
    //                                               text: groupController
    //                                                   .myGroupsList[index].groupName,
    //                                               fontSize: 16.sp,
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     );
    //                                   },
    //                                   itemCount: groupController.myGroupsList.length,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //                 child: Icon(
    //                   Icons.add,
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               floatingActionButtonLocation:
    //                   FloatingActionButtonLocation.centerDocked,
    //             ),
    //           );
    //   },
    // );
  }

  Widget _bottomNavigationBar() {
    return GetBuilder<ControlHomeViewModel>(
      init: ControlHomeViewModel(),
      builder: (controller) => BottomNavigationBar(
        backgroundColor: Colors.grey.shade200,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/home.png",
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("Home".tr),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/group.png",
                fit: BoxFit.contain,
                width: 25,
              ),
            ),
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("Groups".tr),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: const EdgeInsets.only(top: 10), child: Container()),
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/messenger.png",
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("Chats".tr),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                "assets/images/user.png",
                fit: BoxFit.contain,
                width: 20,
              ),
            ),
            label: "",
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text("Profile".tr),
            ),
          ),
        ],
        currentIndex: controller.navigatorValue,
        elevation: 0,
        onTap: (index) {
          if (index != 2) {
            controller.changeSelectedValue(index);
          }
        },
      ),
    );
  }
}
