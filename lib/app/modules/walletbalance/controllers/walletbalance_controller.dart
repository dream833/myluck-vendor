import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';

import '../../../data/function/mydio.dart';

class WalletbalanceController extends GetxController {
  var isLoading = false.obs;
  var totalCoins = 0.obs;
  var totalStars = 0.obs;
  var shopName = "".obs;
  var totalbalance = 0.obs;

  Future<void> fetchWalletBalance() async {
    try {
      isLoading.value = true;
      var shopId = getBox.read(USER_ID);
      var response = await dioPost(
        endUrl: "shopkeeper/shop-balance",
        data: {"shop_id": shopId},
      );

      if (response.statusCode == 200 &&
          response.data["status"] == 200 &&
          response.data["data"] != null) {
        var data = response.data["data"];

        totalCoins(data["total_coins"] ?? 0);
        totalStars(data["total_stars"] ?? 0);
        shopName(data["shop_name"] ?? "");
        totalbalance.value = totalCoins.value + totalStars.value;
      } else {
        print("Invalid API Response");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
