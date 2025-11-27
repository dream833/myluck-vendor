import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import '../../../data/function/mydio.dart';

class AssignPointController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final TextEditingController starController = TextEditingController();
  final TextEditingController coinController = TextEditingController();
  final TextEditingController shoppingprice = TextEditingController();
  var proddescription = TextEditingController();

  var isLoading = false.obs;
  var isCustomerLoaded = false.obs;
  var customerData = {}.obs;

  Future<void> searchCustomer() async {
    final code = searchController.text.trim();
    if (code.isEmpty) {
      Get.snackbar('Error', 'Please enter customer code');
      return;
    }

    isLoading.value = true;
    try {
      final res = await dioPost(
        endUrl: 'shopkeeper/customer-list',
        data: {"customer_code": code},
      );
      var datum = res.data;

      if (datum['status'] == 200 && datum['data'] != null) {
        customerData.value = datum['data'];
        isCustomerLoaded.value = true;
      } else {
        isCustomerLoaded.value = false;
        Get.snackbar('Not Found', datum['message'] ?? 'No customer found');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> assignReward() async {
    if (!isCustomerLoaded.value) {
      Get.snackbar('Error', 'No customer selected');
      return;
    }
    var shopkeeperId = getBox.read(USER_ID);

    int id = int.tryParse(shopkeeperId.toString()) ?? 0;

    final star = starController.text.trim();
    final coin = coinController.text.trim();
    if (star.isEmpty && coin.isEmpty) {
      Get.snackbar('Error', 'Enter at least one reward value');
      return;
    }

    try {
      isLoading.value = true;
      final data = {
        "shop_id": id,
        "customer_id": customerData['id'],
        "star": star,
        "coin": coin,
        "shoping_price": shoppingprice.text.trim(),
        "shoping_details": proddescription.text.trim(),
      };

      final res = await dioPost(endUrl: 'shopkeeper/assign-reward', data: data);
      var datam = res.data;

      if (datam['status'] == 200) {
        Get.snackbar('Success', datam['message'] ?? 'Reward sent successfully');
        starController.clear();
        coinController.clear();
      } else {
        Get.snackbar('Error', datam['message'] ?? 'Failed to assign reward');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// 📷 QR Scan handler
  void scanQr(String scannedCode) {
    searchController.text = scannedCode;
    searchCustomer();
  }
}
