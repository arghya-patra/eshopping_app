import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(mainAxisSize: MainAxisSize.min, children: [
      "Confirm".text.bold.size(18).color(darkFontGrey).make(),
      Divider(),
      "Are you sure you want to exit?"
          .text
          .bold
          .size(18)
          .color(darkFontGrey)
          .make(),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          commonButton(
              color: redColor,
              onpress: () {
                SystemNavigator.pop();
              },
              textColor: whiteColor,
              title: "Yes"),
          commonButton(
              color: redColor,
              onpress: () {
                Navigator.pop(context);
              },
              textColor: whiteColor,
              title: "No")
        ],
      )
    ]).box.color(lightGrey).padding(EdgeInsets.all(3)).roundedSM.make(),
  );
}
