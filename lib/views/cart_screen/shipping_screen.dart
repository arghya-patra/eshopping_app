import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/custom_textfield.dart';
import 'package:eshopping_app/controllers/cart_controller.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/views/cart_screen/payment_method.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Information".text.semiBold.color(darkFontGrey).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: commonButton(
            onpress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => PaymentMethods());
              } else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            title: "Continue",
            textColor: whiteColor,
            color: redColor),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            customTextfield(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextfield(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextfield(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextfield(
                hint: "Postal",
                isPass: false,
                title: "Postal",
                controller: controller.postalcodeController),
            customTextfield(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController)
          ],
        ),
      ),
    );
  }
}
