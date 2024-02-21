import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/controllers/cart_controller.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/cart_screen/shipping_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          width: context.screenWidth - 40,
          height: 60,
          child: commonButton(
              textColor: whiteColor,
              title: "Proceed to shipping",
              onpress: () {
                Get.to(() => const ShippingDetails());
              },
              color: redColor),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping cart".text.semiBold.color(darkFontGrey).make(),
        ),
        body: StreamBuilder(
            stream: FireStoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: "Cart is empty"
                        .text
                        .semiBold
                        .color(darkFontGrey)
                        .make());
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: ((context, index) {
                              return ListTile(
                                  leading: Image.network(
                                    "${data[index]['img']}",
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']} (x ${data[index]['qty']})"
                                          .text
                                          .semiBold
                                          .size(16)
                                          .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .text
                                      .semiBold
                                      .size(16)
                                      .make(),
                                  trailing: IconButton(
                                      onPressed: () {
                                        FireStoreServices.deleteDocument(
                                            data[index].id);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: redColor,
                                      )));
                            }))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price: "
                            .text
                            .semiBold
                            .color(darkFontGrey)
                            .make(),
                        Obx(() => "${controller.totalP.value}"
                            .numCurrency
                            .text
                            .semiBold
                            .color(redColor)
                            .make())
                      ],
                    )
                        .box
                        .padding(EdgeInsets.all(12))
                        .color(lightGrey)
                        .roundedSM
                        .make(),
                    10.heightBox,
                  ]),
                );
              }
            }));
  }
}
