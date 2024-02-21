import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshopping_app/common_widgets/loading_indicator.dart';
import 'package:eshopping_app/services/firestore_services.dart';
import 'package:eshopping_app/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Messages".text.semiBold.color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FireStoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No messages yet".text.semiBold.color(darkFontGrey).make();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: ((context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => const ChatScreen(), arguments: [
                                    data[index]['friend_name'],
                                    data[index]['toId']
                                  ]);
                                },
                                leading: const CircleAvatar(
                                  backgroundColor: redColor,
                                  child: Icon(
                                    Icons.person,
                                    color: whiteColor,
                                  ),
                                ),
                                title: "${data[index]['friend_name']}"
                                    .text
                                    .semiBold
                                    .color(darkFontGrey)
                                    .make(),
                                subtitle: "${data[index]['last_msg']}"
                                    .text
                                    .color(darkFontGrey)
                                    .make(),
                              ),
                            );
                          })))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
