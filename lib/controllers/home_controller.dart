import 'package:eshopping_app/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;
  var username = '';
  var searchController = TextEditingController();
  getUsername() async {
    print("*****************");
    print(currentUser!.uid);

    print("*****************");

    var n = await firestore
        .collection(userCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        print(value.docs.single['name']);
        username = value.docs.single['name'];

        return value.docs.single['name'];
      }
    });
    //  username = n;
  }
}
