import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/services/firestore_services.dart';

import '../../consts/consts.dart';

class WishListscreen extends StatelessWidget {
  const WishListscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No items yet in wishlist"
                .text
                .semiBold
                .color(darkFontGrey)
                .make();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                            leading: Image.network(
                              "${data[index]['p_imgs'][0]}",
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title: "${data[index]['p_name']}"
                                .text
                                .semiBold
                                .size(16)
                                .make(),
                            subtitle: "${data[index]['p_price']}"
                                .text
                                .semiBold
                                .size(16)
                                .make(),
                            trailing: IconButton(
                                onPressed: () async {
                                  await firestore
                                      .collection(productsCollection)
                                      .doc(data[index].id)
                                      .set({
                                    'p_wishlist': FieldValue.arrayRemove(
                                        [currentUser!.uid])
                                  }, SetOptions(merge: true));
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: redColor,
                                )));
                      })),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
