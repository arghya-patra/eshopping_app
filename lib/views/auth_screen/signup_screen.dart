import 'package:eshopping_app/common_widgets/applogo_widget.dart';
import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/custom_textfield.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SignupScreem extends StatefulWidget {
  const SignupScreem({Key? key}) : super(key: key);

  @override
  State<SignupScreem> createState() => _SignupScreemState();
}

class _SignupScreemState extends State<SignupScreem> {
  bool? isCheck = false;
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
          Column(
            children: [
              customTextfield(title: name, hint: namehint),
              customTextfield(title: email, hint: emailHint),
              customTextfield(title: password, hint: passwordHint),
              customTextfield(title: reTypepassword, hint: reTypepasswordHint),
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
              commonButton(
                      title: signup,
                      color: isCheck! ? redColor : fontGrey,
                      textColor: whiteColor,
                      onpress: () {})
                  .box
                  .width(context.screenWidth - 70)
                  .make(),
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
        ],
      )),
    ));
  }
}
