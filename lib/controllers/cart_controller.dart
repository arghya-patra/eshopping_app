import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }
}
