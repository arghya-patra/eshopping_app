import 'package:eshopping_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget homeButton({width, height, icon, String? title}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).make();
}
