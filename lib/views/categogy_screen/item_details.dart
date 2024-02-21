import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
          backgroundColor: lightGrey,
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_outline,
                ))
          ]),
      body: Column(children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  itemCount: 3,
                  aspectRatio: 16 / 9,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imgFc5,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
              10.heightBox,
              title!.text
                  .size(18)
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .make(),
              10.heightBox,
              VxRating(
                onRatingUpdate: (value) {},
                normalColor: textfieldGrey,
                selectionColor: golden,
                count: 5,
                size: 25,
                stepInt: true,
              ),
              10.heightBox,
              "\$30,000".text.color(redColor).fontFamily(bold).size(18).make(),
              10.heightBox,
              Row(
                children: [
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "seller".text.white.fontFamily(semibold).make(),
                      5.heightBox,
                      "Inhouse brands".text.fontFamily(semibold).make()
                    ],
                  )),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.message_rounded,
                      color: darkFontGrey,
                    ),
                  )
                ],
              )
                  .box
                  .height(60)
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .color(textfieldGrey)
                  .make(),
              //color selection section
              20.heightBox,
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Color: ".text.color(textfieldGrey).make(),
                      ),
                      Row(
                          children: List.generate(
                              3,
                              (index) => VxBox()
                                  .size(40, 40)
                                  .roundedFull
                                  .color(Vx.randomPrimaryColor)
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 5))
                                  .make()))
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),

                  //quantity row

                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Quantity: ".text.color(textfieldGrey).make(),
                      ),
                      Row(children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove),
                        ),
                        "0"
                            .text
                            .size(16)
                            .fontFamily(bold)
                            .color(darkFontGrey)
                            .make(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                        ),
                        10.widthBox,
                        "(0 availble)"
                            .text
                            .size(16)
                            .fontFamily(bold)
                            .color(textfieldGrey)
                            .make(),
                      ]),

                      //total row
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),

                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: "Total: ".text.color(textfieldGrey).make(),
                      ),
                      "\$0.00"
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(16)
                          .make()
                    ],
                  ).box.padding(const EdgeInsets.all(8)).make(),
                ],
              ).box.white.shadowSm.make(),

              //description section
              10.heightBox,
              "Description"
                  .text
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .make(),
              10.heightBox,
              "This is a dummy item and dummy desccriptoion here..."
                  .text
                  .color(darkFontGrey)
                  .fontFamily(regular)
                  .make(),
              //buttons selections
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                    itemDetailButtonlist.length,
                    (index) => ListTile(
                          title: itemDetailButtonlist[index]
                              .text
                              .color(darkFontGrey)
                              .semiBold
                              .make(),
                          trailing: const Icon(Icons.arrow_forward),
                        )),
              ),
              20.heightBox,
              productsYouMayLike.text.bold.size(16).color(darkFontGrey).make(),
              20.heightBox,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        6,
                        (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  imgP1,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                                10.heightBox,
                                "Laptop 4Gb/64Gb"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "\$400"
                                    .text
                                    .fontFamily(semibold)
                                    .color(redColor)
                                    .make(),
                              ],
                            )
                                .box
                                .white
                                .roundedSM
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(10))
                                .make())),
              )
            ]),
          ),
        )),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: commonButton(
              color: redColor,
              onpress: () {},
              textColor: whiteColor,
              title: "Add to cart"),
        )
      ]),
    );
  }
}
