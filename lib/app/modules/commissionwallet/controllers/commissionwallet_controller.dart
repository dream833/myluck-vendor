import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class CommissionwalletController extends GetxController {
  RxBool loading = false.obs;
  RxInt star = 0.obs;
  RxInt coin = 0.obs;

  final shopId = getBox.read(USER_ID);

  @override
  void onInit() {
    super.onInit();
    fetchCommissionBalance();
  }

  Future<void> fetchCommissionBalance() async {
    loading.value = true;

    var response = await dioPost(
      endUrl: "shopkeeper/commission-balance",
      data: {"shop_id": shopId},
    );
    var data = response.data;
    if (data["status"] == 200) {
      star(data["data"]["star"] ?? 0);
      coin(data["data"]["coin"] ?? 0);
    }

    loading.value = false;
  }
}
