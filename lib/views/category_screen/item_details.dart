import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:eshopping_app/controllers/product_controller.dart';
import 'package:eshopping_app/views/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
            ),
            backgroundColor: lightGrey,
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                  )),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWishlist(data.id, context);
                        //controller.isFav(false);
                      } else {
                        controller.addToWishlist(data.id, context);
                        // controller.isFav(true);
                      }
                    },
                    icon: Icon(
                      Icons.favorite_outlined,
                      color: controller.isFav.value ? redColor : darkFontGrey,
                    )),
              )
            ]),
        body: Column(children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        itemCount: data['p_imgs'].length,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemBuilder: (context, index) {
                          return Image.network(
                            data["p_imgs"][index],
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
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      isSelectable: false,
                      count: 5,
                      size: 25,
                      stepInt: false,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['p_seller']}"
                                .text
                                .white
                                .fontFamily(semibold)
                                .make(),
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
                        ).onTap(() {
                          Get.to(() => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    //color selection section
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color: ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 5))
                                                  .make()
                                                  .onTap(() async {
                                                controller
                                                    .changeColorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorindex.value,
                                                  child: const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ))
                                            ],
                                          )))
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //quantity row

                          Obx(
                            () => Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Quantity: "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Row(children: [
                                  IconButton(
                                    onPressed: () {
                                      controller.decreasedQuantity();
                                      controller.calculateTotalPrice(
                                          int.parse(data['p_price']));
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: controller.quantity.value == 0
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  controller.quantity.value.text
                                      .size(16)
                                      .fontFamily(bold)
                                      .color(darkFontGrey)
                                      .make(),
                                  IconButton(
                                    onPressed: () {
                                      controller.increasedQuantity(
                                          int.parse(data['p_quantity']));

                                      controller.calculateTotalPrice(
                                          int.parse(data['p_price']));
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: controller.quantity.value ==
                                              int.parse(data['p_quantity'])
                                          ? Colors.grey
                                          : Colors.black,
                                    ),
                                  ),
                                  10.widthBox,
                                  "(${data['p_quantity']} availble)"
                                      .text
                                      .size(16)
                                      .fontFamily(bold)
                                      .color(textfieldGrey)
                                      .make(),
                                ]),

                                //total row
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ),

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total: ".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .fontFamily(bold)
                                  .size(16)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    //description section
                    10.heightBox,
                    "Description"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}"
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
                    productsYouMayLike.text.bold
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              6,
                              (index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
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
                onpress: () {
                  if (controller.quantity.value == 0) {
                    VxToast.show(context, msg: "Select quantity");
                  } else {
                    controller.addToCart(
                      color: data['p_colors'][controller.colorindex.value],
                      context: context,
                      img: data['p_imgs'][0],
                      qty: controller.quantity.value,
                      vendorID: data['vendor_id'],
                      sellername: data['p_seller'],
                      title: data['p_name'],
                      tprice: controller.totalPrice.value,
                    );
                    VxToast.show(context, msg: "Added to cart");
                  }
                },
                textColor: whiteColor,
                title: "Add to cart"),
          )
        ]),
      ),
    );
  }
}
