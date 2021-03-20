import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_at/helper/constant.dart';
import 'package:team_at/viewModel/posts_view_model.dart';
import 'file:///D:/Projects/Flutter/team_at/lib/view/AuthonticationScreens/RegistrationScreens/register_view.dart';
import 'package:team_at/widget/CustomButton.dart';
import 'package:team_at/widget/custom_text.dart';
import 'package:team_at/widget/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_at/viewModel/auth_viewModel.dart';


class LoginView extends StatelessWidget {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
///-----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (controller) =>
            ModalProgressHUD(
              inAsyncCall: controller.isLoading,
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      SizedBox(height: 124.h,),
                      _headTitle(size),
                      SizedBox(height: 24.h,),
                      _emailField(size, controller),
                      passwordField(size, controller),
                      CustomText(
                        text: "Forget password ?".tr,
                        fontColor: Colors.red,
                        fontSize: 12,

                      ),
                      SizedBox(
                        height: 68.h,
                      ),
                      signInButton(controller),
                      SizedBox(
                        height: 24.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don't have an account?".tr,
                            fontColor: Color(0xff757575),
                            fontSize: 12,

                          ),
                          showSignUpView(),
                        ],
                      ),
                      SizedBox(height: 20.h,)
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }

  InkWell showSignUpView() {
    return InkWell(
      onTap: () {
        Get.to(() => RegisterView());
      },
      child: CustomText(
        text: "Sign Up".tr,
        fontColor: kMainColor,
        fontSize: 12,

      ),
    );
  }

  Padding signInButton(AuthViewModel controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GetBuilder<PostsViewModel>(
        init: PostsViewModel(),
        builder:(postController) => CustomButton(
          buttonHeight: 58.h,
          buttonWidth: 375.w,
          text: "Sign in".tr,
          onClick: () async {
            _key.currentState.validate();
            _key.currentState.save();
            controller.changeIsLoading(true);
            await controller.signInWithEmailAndPassword();
            SharedPreferences preferences = await SharedPreferences.getInstance();
            String userID = preferences.getString("userID");
            await postController.getUserFromFireStore(userID);
            await postController.getAllUser();
            await postController.getAllGroups();
            await postController.getAllPostsByUserId();
            await postController.getAllFollowingGroupsPostsByUserId();
            controller.changeIsLoading(false);

          },
          buttonRadius: 9.0,
        ),
      ),
    );
  }

  Container passwordField(Size size, AuthViewModel controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: 130.h,
      child: Column(
        children: [
          CustomText(
            text: "password".tr,
            fontColor: Colors.black,
            textAlignment: Alignment.centerLeft,
            fontSize: 16.sp,

          ),
          SizedBox(height: 8.h,),
          Expanded(
            child: CustomTextFormField(
              fieldHeight: 58.h,
              withSuffixIcon: true,
              prefixIconColor: Color(0xff9a9595),
              focusedBorderColor: kSecondColor,
              validator: (val) {
                if (val.isEmpty)
                  return "passwordEmpty".tr;
              },
              borderRadius: 0,
              onSave: (val) {
                controller.password = val;
              },
              hintText: "***********",
              obscureText: true,
              prefixIcon: Icons.lock,
            ),
          ),
        ],
      ),
    );
  }

  Container _emailField(Size size, AuthViewModel controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: 130.h,
      child: Column(
        children: [
          CustomText(
            text: "Email".tr,
            fontColor: Colors.black,
            textAlignment: Alignment.centerLeft,
            fontSize: 16.sp,

          ),
          SizedBox(height: 8.h),
          Expanded(
            child: CustomTextFormField(
              fieldHeight: 58.h,
              focusedBorderColor: kSecondColor,
              prefixIconColor: Color(0xff9a9595),
              validator: (val) {
                if (val.isEmpty)
                  return "emailEmpty".tr;
              },
              borderRadius: 0,
              onSave: (val) {
                controller.email = val;
              },
              hintText: "saadelnely123@gmail.com",
              prefixIcon: Icons.email_outlined,
            ),
          ),
        ],
      ),
    );
  }

  Container _headTitle(Size size) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 85.h,
      width: size.width,
      child: Column(
        children: [
          CustomText(
            text: "Let's Sign you in".tr,
            fontWeight: FontWeight.bold,
            fontColor: Colors.black,
            fontSize: 20.sp,
            textAlignment: Alignment.topLeft,
          ),
          CustomText(
            text: "Welcome back we have been missed".tr,
            fontColor: Colors.black,
            fontSize: 15.sp,
            textAlignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }
}
