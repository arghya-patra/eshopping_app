import 'package:eshopping_app/common_widgets/exit_dialog.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/controllers/home_controller.dart';
import 'package:eshopping_app/views/cart_screen/cart_screen.dart';
import 'package:eshopping_app/views/homeScreen/home_screen.dart';
import 'package:eshopping_app/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/images.dart';
import '../category_screen/catagory_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCart,
            width: 26,
          ),
          label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: "categories"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: "Profile")
    ];
    var navBody = [
      HomeScreen(),
      CartScreen(),
      CategoryScreen(),
      ProfileScreen()
    ];
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
          body: Column(children: [
            Obx(
              () => Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ]),
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              currentIndex: controller.currentNavIndex.value,
              items: navBarItem,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              backgroundColor: whiteColor,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                controller.currentNavIndex.value = value;
              },
            ),
          )),
    );
  }
}
