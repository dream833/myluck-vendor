import 'package:get/get.dart';

import '../../../data/function/mydio.dart';
import '../model/notification_model.dart';

class NotificationPageController extends GetxController {
  RxBool loading = false.obs;
  RxList<NotificationModel> list = <NotificationModel>[].obs;

  RxInt total = 0.obs;

  @override
  void onInit() {
    fetchNotifications();
    super.onInit();
  }

  Future<void> fetchNotifications() async {
    loading.value = true;

    try {
      final response = await dioPost(
        endUrl: "shopkeeper/notification-list",
        data: {"shop_id": "22"},
      );

      var data = response.data;

      if (data["status"] == 200) {
        total(data["total"] ?? 0);
        List listData = data["data"];

        list.value = listData
            .map((e) => NotificationModel.fromJson(e))
            .toList();
      } else {
        list.clear();
        total.value = 0;
      }
    } catch (e) {
      list.clear();
      total.value = 0;
    } finally {
      loading.value = false;
    }
  }
}
