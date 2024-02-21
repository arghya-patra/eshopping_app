import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/views/orders_screen/components/order_placed_details.dart';
import 'package:eshopping_app/views/orders_screen/components/order_status.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: "Order Details".text.semiBold.make()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Placed",
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Confirmed",
                showDone: data['order_confirmed']),
            orderStatus(
                color: Colors.yellow,
                icon: Icons.car_crash,
                title: "On Delivery",
                showDone: data['order_on_delivery']),
            orderStatus(
                color: Colors.green,
                icon: Icons.done_all_outlined,
                title: "Delivered",
                showDone: data['order_delivered']),
            Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlacedDetails(
                    d1: data['order_code'],
                    d2: data['shipping_method'],
                    title1: "Order code",
                    title2: "Shipping method"),
                orderPlacedDetails(
                    d1: intl.DateFormat()
                        .add_yMd()
                        .format(data['order_date'].toDate()),
                    d2: data['shipping_method'],
                    title1: "Order date",
                    title2: "Payment method"),
                orderPlacedDetails(
                    d1: "Unpaid",
                    d2: "Order placed",
                    title1: "Payment Status",
                    title2: "Delivery Status"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.semiBold.make(),
                          "${data['order_by_name']}".text.make(),
                          "${data['order_by_email']}".text.make(),
                          "${data['order_by_address']}".text.make(),
                          "${data['order_by_city']}".text.make(),
                          "${data['order_by_state']}".text.make(),
                          "${data['order_by_phone']}".text.make(),
                          "${data['order_by_postalcode']}".text.make(),
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total amount".text.semiBold.make(),
                            "${data['total_amount']}"
                                .text
                                .color(redColor)
                                .bold
                                .make()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.white.make(),
            Divider(),
            10.heightBox,
            "Ordered Product".text.semiBold.color(darkFontGrey).makeCentered(),
            10.heightBox,
            ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(data['orders'].length, (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlacedDetails(
                            title1: data['orders'][index]['title'],
                            title2: data['orders'][index]['tprice'],
                            d1: "${data['orders'][index]['qty']} x ",
                            d2: "Refundable",
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: Color(data['orders'][index]['color']),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    }).toList())
                .box
                .outerShadowSm
                .margin(const EdgeInsets.only(bottom: 4))
                .white
                .make(),
            20.heightBox,
          ]),
        ),
      ),
    );
  }
}
