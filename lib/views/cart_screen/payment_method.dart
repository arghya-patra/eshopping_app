import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:eshopping_app/controllers/cart_controller.dart';
import 'package:eshopping_app/views/homeScreen/home.dart';

import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : commonButton(
                  onpress: () async {
                    controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed successfully");
                    Get.offAll(const Home());
                  },
                  title: "Place my order",
                  textColor: whiteColor,
                  color: redColor),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "Choose payment methode"
                .text
                .semiBold
                .color(darkFontGrey)
                .make()),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
                children: List.generate(paymentMethodsImgList.length, (index) {
              return Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        width: 4)),
                margin: EdgeInsets.only(bottom: 8),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      paymentMethodsImgList[index],
                      width: double.infinity,
                      height: 120,
                      colorBlendMode: controller.paymentIndex.value == index
                          ? BlendMode.darken
                          : BlendMode.color,
                      color: controller.paymentIndex.value == index
                          ? Colors.black.withOpacity(0.3)
                          : Colors.transparent,
                      fit: BoxFit.cover,
                    ),
                    controller.paymentIndex.value == index
                        ? Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                activeColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                value: true,
                                onChanged: (value) {}),
                          )
                        : Container(),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: paymentMethods[index]
                            .text
                            .white
                            .semiBold
                            .size(16)
                            .make())
                  ],
                ),
              ).onTap(() {
                controller.changePaymentIndex(index);
              });
            })),
          ),
        ),
      ),
    );
  }
}
