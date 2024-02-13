import 'dart:io';
import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/common_widgets/common_button.dart';
import 'package:eshopping_app/common_widgets/custom_textfield.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/controllers/profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // data["imageUrl"] == '' && controller.profileImagePath.isEmpty
            //     ? Image.asset(
            //         imgProfile2,
            //         width: 100,
            //         fit: BoxFit.cover,
            //       ).box.roundedFull.clip(Clip.antiAlias).make()
            //     : data["imageUrl"] != '' && controller.profileImagePath.isEmpty
            //         ? Image.network(
            //             data["imageUrl"],
            //             width: 100,
            //             fit: BoxFit.cover,
            //           ).box.roundedFull.clip(Clip.antiAlias).make()
            //         : Image.file(
            //             File(controller.profileImagePath.value),
            //             width: 100,
            //             fit: BoxFit.cover,
            //           ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            commonButton(
                color: redColor,
                onpress: () {
                  controller.changeImage(context);
                },
                title: "Change",
                textColor: whiteColor),
            Divider(),
            20.heightBox,
            customTextfield(
                hint: namehint,
                title: name,
                isPass: false,
                controller: controller.nameController),
            10.heightBox,
            customTextfield(
                hint: passwordHint,
                title: oldpassword,
                isPass: true,
                controller: controller.oldpassController),
            10.heightBox,
            customTextfield(
                hint: passwordHint,
                title: newPassword,
                isPass: true,
                controller: controller.newpassController),
            20.heightBox,
            controller.isLoading.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: commonButton(
                        color: redColor,
                        onpress: () async {
                          controller.isLoading(true);

                          //if image is not selected
                          if (controller.profileImagePath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImageLink = data['imageUrl'];
                          }
                          if (data['password'] ==
                              controller.oldpassController.text) {
                            // await controller.changeAuthPassword(
                            //     email: data['email'],
                            //     password: controller.oldpassController.text,
                            //     newpassword: controller.newpassController.text);

                            await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text);
                            VxToast.show(context, msg: "Updated");
                          } else {
                            VxToast.show(context, msg: "Password not match");
                            controller.isLoading(false);
                          }
                        },
                        title: "Save",
                        textColor: whiteColor),
                  ),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .roundedSM
            .make(),
      ),
    ));
  }
}


//
