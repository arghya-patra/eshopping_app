import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:eshopping_app/controllers/auth_controller.dart';
import 'package:eshopping_app/views/auth_screen/login_screen.dart';
import 'package:eshopping_app/views/profile_screen/components/details_card.dart';
import 'package:eshopping_app/views/profile_screen/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      body: SafeArea(
          child: Column(children: [
        //edit profile button
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Align(
            alignment: Alignment.topRight,
            child: Icon(
              Icons.edit,
              color: whiteColor,
            ),
          ).onTap(() {
            Get.to(() => EditProfileScreen());
          }),
        ),

        //user details section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Image.asset(
                imgProfile2,
                width: 100,
                fit: BoxFit.cover,
              ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.widthBox,
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Dummy user ".text.white.semiBold.make(),
                  "Dummyuser@email.com ".text.white.make()
                ],
              )),
              OutlinedButton(
                  onPressed: () async {
                    await Get.put(Authcontroller()).signOutMethod(context);
                    Get.offAll(() => const LoginScreen());
                  },
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(color: whiteColor)),
                  child: "logout".text.white.semiBold.make())
            ],
          ),
        ),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            detailsCard(
                count: "00",
                title: "In your cart",
                width: context.screenWidth / 3.4),
            detailsCard(
                count: "10",
                title: "In your wishlist",
                width: context.screenWidth / 3.4),
            detailsCard(
                count: "23",
                title: "In your order",
                width: context.screenWidth / 3.4),
          ],
        ),

        //buttons section
        ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.asset(
                      profileButtonsIcon[index],
                      width: 22,
                    ),
                    title: profileButtonslist[index]
                        .text
                        .semiBold
                        .color(darkFontGrey)
                        .make(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: lightGrey,
                  );
                },
                itemCount: profileButtonslist.length)
            .box
            .white
            .rounded
            .margin(const EdgeInsets.all(12))
            .padding(const EdgeInsets.symmetric(horizontal: 16))
            .make()
            .box
            .color(redColor)
            .make()
      ])),
    ));
  }
}
