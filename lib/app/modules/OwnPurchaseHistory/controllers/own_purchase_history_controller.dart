import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class OwnPurchaseHistoryController extends GetxController {
  var isLoading = false.obs;
  var purchases = [].obs;
  var message = ''.obs;

  final box = GetStorage();

  Future<void> fetchPurchaseHistory() async {
    final shopId = box.read(USER_ID)?.toString() ?? '';

    if (shopId.isEmpty) {
      message.value = "Shop ID not found!";
      return;
    }

    isLoading.value = true;
    try {
      final response = await dioPost(
        endUrl: 'shopkeeper/recharge-history',
        data: {"shop_id": shopId},
      );

      final data = response.data;

      if (data['status'] == 200 &&
          data['data'] != null &&
          data['data'].isNotEmpty) {
        purchases.assignAll(data['data']);
        message.value = "";
      } else {
        purchases.clear();
        message.value = "No purchase records found.";
      }
    } catch (e) {
      message.value = "Something went wrong: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
