import 'package:flutter/material.dart';
import 'package:eshopping_app/consts/consts.dart';

Widget commonButton({onpress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color, padding: const EdgeInsets.all(10)),
      onPressed: onpress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
