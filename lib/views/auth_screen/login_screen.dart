import 'package:eshopping_app/common_widgets/applogo_widget.dart';
import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/custom_textfield.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:eshopping_app/controllers/auth_controller.dart';
import 'package:eshopping_app/views/auth_screen/signup_screen.dart';
import 'package:eshopping_app/views/homeScreen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(Authcontroller());
  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          appLogoWidget(),
          10.heightBox,
          "Login to $appname".text.fontFamily(bold).white.size(18).make(),
          10.heightBox,
          Obx(
            () => Column(
              children: [
                customTextfield(
                    title: email,
                    hint: emailHint,
                    isPass: false,
                    controller: controller.emailController),
                customTextfield(
                    title: password,
                    hint: passwordHint,
                    isPass: true,
                    controller: controller.passWordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPass.text.make())),
                5.heightBox,
                controller.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : commonButton(
                        title: "Login",
                        color: redColor,
                        textColor: whiteColor,
                        onpress: () async {
                          controller.isLoading(true);
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: loggedIn);
                              Get.offAll(() => Home());
                            } else {
                              controller.isLoading(false);
                            }
                          });
                        }).box.width(context.screenWidth - 70).make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                commonButton(
                    title: signup,
                    color: golden,
                    textColor: whiteColor,
                    onpress: () {
                      Get.to(() => SignupScreen());
                    }).box.width(context.screenWidth - 70).make(),
                10.heightBox,
                loginwith.text.make(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                          padding: EdgeInsets.all(8),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ))),
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(15))
                .width(context.screenWidth - 70)
                .make(),
          ),
        ],
      )),
    ));
  }
}
