import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:eshopping_app/controllers/chats_controller.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/chat_screen/components/sender_bubble.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: "${controller.friendName}"
                .text
                .semiBold
                .color(darkFontGrey)
                .make()),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: loadingIndicator(),
                        )
                      : Expanded(
                          child: StreamBuilder(
                          stream: FireStoreServices.getChatMessages(
                              controller.chatDocId.toString()),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: loadingIndicator(),
                              );
                            } else if (snapshot.data!.docs.isEmpty) {
                              return Center(
                                child: "Send a message".text.make(),
                              );
                            } else {
                              return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] == currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: senderBubble(data));
                              }).toList());
                            }
                          },
                        )

                          //
                          ),
                ),
                10.heightBox,
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: controller.msgController,
                      decoration: const InputDecoration(
                          hintText: "Type your message",
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: textfieldGrey))),
                    )),
                    IconButton(
                        onPressed: (() {
                          controller.sendMsg(controller.msgController.text);
                          controller.msgController.clear();
                        }),
                        icon: const Icon(
                          Icons.send,
                          color: redColor,
                        ))
                  ],
                )
                    .box
                    .height(80)
                    .padding(EdgeInsets.all(12))
                    .margin(const EdgeInsets.only(bottom: 8))
                    .make()
              ],
            )));
  }
}
