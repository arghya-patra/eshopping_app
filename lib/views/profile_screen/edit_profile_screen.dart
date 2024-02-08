import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/custom_textfield.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imgProfile2,
            width: 100,
            fit: BoxFit.cover,
          ).box.roundedFull.clip(Clip.antiAlias).make(),
          10.heightBox,
          commonButton(
              color: redColor,
              onpress: () {},
              title: "Change",
              textColor: whiteColor),
          Divider(),
          20.heightBox,
          customTextfield(hint: namehint, title: name, isPass: false),
          customTextfield(hint: password, title: password, isPass: true),
          20.heightBox,
          SizedBox(
            width: context.screenWidth - 60,
            child: commonButton(
                color: redColor,
                onpress: () {},
                title: "Save",
                textColor: whiteColor),
          ),
        ],
      )
          .box
          .white
          .shadowSm
          .padding(const EdgeInsets.all(16))
          .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
          .roundedSM
          .make(),
    ));
  }
}
