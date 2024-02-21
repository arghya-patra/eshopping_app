import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/views/category_screen/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CatagoryDetails extends StatelessWidget {
  final String? title;
  const CatagoryDetails({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(title: title!.text.fontFamily(bold).white.make()),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
                children: List.generate(
                    6,
                    (index) => "Baby Clothing"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(120, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 5))
                        .make())),
          ),
          5.heightBox,
          Expanded(
              child: Container(
            color: lightGrey,
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8),
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        imgP5,
                        width: 200,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      "Laptop 4Gb/64Gb"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      10.heightBox,
                      "\$400".text.fontFamily(semibold).color(redColor).make(),
                    ],
                  )
                      .box
                      .white
                      .roundedSM
                      .margin(const EdgeInsets.symmetric(
                        horizontal: 4,
                      ))
                      .padding(const EdgeInsets.all(12))
                      .make()
                      .onTap(() {
                    Get.to(() => ItemDetails(
                          title: "Dummy item",
                        ));
                  });
                }),
          ))
        ]),
      ),
    ));
  }
}
