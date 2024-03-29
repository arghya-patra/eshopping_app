import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/home_button.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:eshopping_app/controllers/home_controller.dart';
import 'package:eshopping_app/controllers/product_controller.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/category_screen/item_details.dart';
import 'package:eshopping_app/views/homeScreen/components/featured_button.dart';
import 'package:eshopping_app/views/homeScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pController = Get.put(ProductController());
    var controller = Get.find<HomeController>();
    return Scaffold(
      body: Container(
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(
          children: [
            // Container(
            //   color: redColor,
            //   height: 20,
            //   width: 20,
            // ).box.make().onTap(() {
            //   auth.signOut();
            // }),
            Container(
              alignment: Alignment.center,
              color: lightGrey,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search).onTap(() {
                      if (controller
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(() => SearchScreen(
                              title: controller.searchController.text,
                            ));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: "Search anything ..",
                    hintStyle: TextStyle(color: textfieldGrey)),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            sliderList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            2,
                            (index) => homeButton(
                                  height: context.screenHeight * .15,
                                  width: context.screenWidth / 2.5,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashSale,
                                ))),
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            secondSliderList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    10.heightBox,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                            3,
                            (index) => homeButton(
                                  height: context.screenHeight * .15,
                                  width: context.screenWidth / 3.5,
                                  icon: index == 0
                                      ? icTopCategories
                                      : index == 1
                                          ? icBrands
                                          : icTopSeller,
                                  title: index == 0
                                      ? topcategories
                                      : index == 1
                                          ? brand
                                          : topSeller,
                                ))),
                    20.heightBox,
                    Align(
                      alignment: Alignment.center,
                      child: featuredcategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            3,
                            (index) => Column(
                                  children: [
                                    featuredButton(
                                        icon: featuredImages1[index],
                                        title: featuredtitles1[index]),
                                    10.heightBox,
                                    featuredButton(
                                        icon: featuredImages2[index],
                                        title: featuredtitles2[index])
                                  ],
                                )),
                      ),
                    ),
                    20.heightBox,
                    Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white
                                .fontFamily(bold)
                                .size(18)
                                .make(),
                            10.heightBox,
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FutureBuilder(
                                  future:
                                      FireStoreServices.getFeaturedProducts(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: loadingIndicator(),
                                      );
                                    } else if (snapshot.data!.docs.isEmpty) {
                                      return "No featured product"
                                          .text
                                          .makeCentered();
                                    } else {
                                      //
                                      var featuredData = snapshot.data!.docs;

                                      return Row(
                                          children: List.generate(
                                              featuredData.length,
                                              (index) => Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Image.network(
                                                        featuredData[index]
                                                            ['p_imgs'][0],
                                                        width: 150,
                                                        height: 130,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_name']}"
                                                          .text
                                                          .fontFamily(semibold)
                                                          .color(darkFontGrey)
                                                          .make(),
                                                      10.heightBox,
                                                      "${featuredData[index]['p_price']}"
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
                                                      .margin(const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4))
                                                      .padding(
                                                          const EdgeInsets.all(
                                                              10))
                                                      .make()
                                                      .onTap(() {
                                                    Get.to(() => ItemDetails(
                                                          title:
                                                              "${featuredData[index]['p_name']}",
                                                          data: featuredData[
                                                              index],
                                                        ));
                                                  })));
                                    }
                                  }),
                            )
                          ],
                        )),
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: sliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            sliderList[index],
                            fit: BoxFit.fill,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(const EdgeInsets.symmetric(horizontal: 8))
                              .make();
                        }),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "All products"
                          .text
                          .semiBold
                          .color(darkFontGrey)
                          .size(18)
                          .make(),
                    ),
                    20.heightBox,
                    StreamBuilder(
                        stream: FireStoreServices.getAllproducts(),
                        builder:
                            ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: loadingIndicator(),
                            );
                          } else {
                            var allProductsData = snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allProductsData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300,
                                ),
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        allProductsData[index]['p_imgs'][0],
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      Spacer(),
                                      "${allProductsData[index]['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "${allProductsData[index]['p_price']}"
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
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemDetails(
                                          title:
                                              "${allProductsData[index]['p_name']}",
                                          data: allProductsData[index],
                                        ));
                                  });
                                });
                          }
                        }))
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
