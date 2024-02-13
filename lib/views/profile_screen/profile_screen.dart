import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/consts/lists.dart';
import 'package:eshopping_app/controllers/auth_controller.dart';
import 'package:eshopping_app/controllers/profile_controller.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/auth_screen/login_screen.dart';
import 'package:eshopping_app/views/profile_screen/components/details_card.dart';
import 'package:eshopping_app/views/profile_screen/edit_profile_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FireStoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
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
                          controller.nameController.text = data["name"];
                          Get.to(() => EditProfileScreen(
                                data: data,
                              ));
                        }),
                      ),

                      //user details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            // data["imageUrl"] == ''
                            //     ? Image.asset(
                            //         imgProfile2,
                            //         width: 100,
                            //         fit: BoxFit.cover,
                            //       ).box.roundedFull.clip(Clip.antiAlias).make()
                            //     : Image.network(
                            //         data["imageUrl"],
                            //         width: 100,
                            //         fit: BoxFit.cover,
                            //       ).box.roundedFull.clip(Clip.antiAlias).make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data["name"]}".text.white.semiBold.make(),
                                "${data["email"]}".text.white.make()
                              ],
                            )),
                            OutlinedButton(
                                onPressed: () async {
                                  await Get.put(Authcontroller())
                                      .signOutMethod(context);
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
                              count: "${data["cart_count"]}",
                              title: "In your cart",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: "${data["wishlist_count"]}",
                              title: "In your wishlist",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: "${data["order_count"]}",
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
                              separatorBuilder:
                                  (BuildContext context, int index) {
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
                    ]));
                  }
                })));
  }
}
