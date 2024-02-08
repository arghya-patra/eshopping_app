import 'package:eshopping_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard({width, String? title, String? count}) {
  return Column(
    children: [
      count!.text.bold.color(darkFontGrey).make(),
      5.heightBox,
      title!.text.bold.color(darkFontGrey).make()
    ],
  )
      .box
      .white
      .rounded
      .width(width)
      .height(60)
      .padding(const EdgeInsets.all(4))
      .make();
}
