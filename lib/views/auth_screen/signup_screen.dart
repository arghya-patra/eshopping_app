import 'package:eshopping_app/common_widgets/applogo_widget.dart';
import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/custom_textfield.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:eshopping_app/controllers/auth_controller.dart';
import 'package:eshopping_app/views/homeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(Authcontroller());
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.08).heightBox,
          appLogoWidget(),
          5.heightBox,
          "SignUp to $appname".text.fontFamily(bold).white.size(18).make(),
          5.heightBox,
          Obx(
            () => Column(
              children: [
                customTextfield(
                    title: name,
                    hint: namehint,
                    controller: nameController,
                    isPass: false),
                customTextfield(
                    title: email,
                    hint: emailHint,
                    controller: emailController,
                    isPass: false),
                customTextfield(
                    title: password,
                    hint: passwordHint,
                    controller: passwordController,
                    isPass: true),
                customTextfield(
                    title: reTypepassword,
                    hint: reTypepasswordHint,
                    controller: passwordRetypeController,
                    isPass: true),
                5.heightBox,
                Row(
                  children: [
                    Checkbox(
                        checkColor: whiteColor,
                        activeColor: redColor,
                        value: isCheck,
                        onChanged: ((newVal) {
                          setState(() {
                            isCheck = newVal;
                          });
                        })),
                    5.widthBox,
                    Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                      TextSpan(
                          text: "I agree to the ",
                          style: TextStyle(fontFamily: bold, color: fontGrey)),
                      TextSpan(
                          text: termsAndCondition,
                          style: TextStyle(fontFamily: bold, color: redColor)),
                      TextSpan(
                          text: " and ",
                          style: TextStyle(fontFamily: bold, color: fontGrey)),
                      TextSpan(
                          text: privacyPolicy,
                          style: TextStyle(fontFamily: bold, color: redColor)),
                    ]))),
                  ],
                ),
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : commonButton(
                        title: signup,
                        color: isCheck! ? redColor : fontGrey,
                        textColor: whiteColor,
                        onpress: () async {
                          if (isCheck != false) {
                            controller.isLoading(true);
                            try {
                              await controller
                                  .signUpMethod(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                return controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text);
                              }).then((value) {
                                VxToast.show(context, msg: loggedIn);
                                Get.offAll(() => Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                              controller.isLoading(false);
                            }
                          }
                        }).box.width(context.screenWidth - 70).make(),
                5.heightBox,
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: alreadyHaveAccount,
                      style: TextStyle(color: fontGrey)),
                  TextSpan(text: login, style: TextStyle(color: redColor))
                ])).onTap(() {
                  Get.back();
                })
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(12))
                .width(context.screenWidth - 70)
                .make(),
          ),
        ],
      )),
    ));
  }
}
