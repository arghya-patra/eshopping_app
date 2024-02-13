import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/controllers/product_controller.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/category_screen/item_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class categoryDetails extends StatelessWidget {
  final String? title;
  const categoryDetails({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(title: title!.text.fontFamily(bold).white.make()),
      body: StreamBuilder(
          stream: FireStoreServices.getProducts(title),
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "No data found".text.semiBold.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return Container(
                padding: EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .white
                                    .rounded
                                    .size(120, 60)
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 5))
                                    .make())),
                      ),
                      5.heightBox,
                      Expanded(
                          child: Container(
                        color: lightGrey,
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 250,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    data[index]['p_imgs'][0],
                                    width: 200,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  "${data[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${data[index]['p_price']}"
                                      .numCurrency
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
                                    horizontal: 4,
                                  ))
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(() {
                                Get.to(() => ItemDetails(
                                      title: "${data[index]['p_name']}",
                                      data: data[index],
                                    ));
                              });
                            }),
                      ))
                    ]),
              );
            }
          })),
    ));
  }
}

//

