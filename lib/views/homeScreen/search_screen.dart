import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/category_screen/item_details.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: title!.text.color(redColor).make(),
        ),
        body: FutureBuilder(
            future: FireStoreServices.searchProducts(title),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No products found".text.color(redColor).make();
              } else {
                var data = snapshot.data!.docs;
                var filtered = data
                    .where(((element) => element['p_name']
                        .toString()
                        .toLowerCase()
                        .contains(title!.toLowerCase())))
                    .toList();
                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 300,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8),
                  children: filtered
                      .mapIndexed((currentValue, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                filtered[index]['p_imgs'][0],
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                              Spacer(),
                              "${filtered[index]['p_name']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              10.heightBox,
                              "${filtered[index]['p_price']}"
                                  .text
                                  .fontFamily(semibold)
                                  .color(redColor)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .outerShadowMd
                              .roundedSM
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .padding(const EdgeInsets.all(12))
                              .make()
                              .onTap(() {
                            Get.to(() => ItemDetails(
                                  title: "${filtered[index]['p_name']}",
                                  data: filtered[index],
                                ));
                          }))
                      .toList(),
                );
              }
            }));
  }
}
