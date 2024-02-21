import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/orders_screen/orders_details.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders yet".text.semiBold.color(darkFontGrey).make();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    leading:
                        "${index + 1}".text.semiBold.color(redColor).make(),
                    title: data[index]['order_code']
                        .toString()
                        .text
                        .semiBold
                        .color(redColor)
                        .make(),
                    subtitle: data[index]['total_amount']
                        .toString()
                        .numCurrency
                        .text
                        .semiBold
                        .color(darkFontGrey)
                        .make(),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      color: darkFontGrey,
                    ),
                  );
                }));
          }
        },
      ),
    );
  }
}
