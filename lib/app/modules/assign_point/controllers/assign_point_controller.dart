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
  var isScanned = false;

  var isLoading = false.obs;
  var isCustomerLoaded = false.obs;
  var customerData = {}.obs;

  Future<void> searchCustomer() async {
    final code = searchController.text.trim();
    if (code.isEmpty) {
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
        showTopSnack(datum['message'] ?? 'No customer found', isError: true);
      }
    } catch (e) {
      showSnack('Error', e.toString(), bg: Colors.redAccent);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> assignReward() async {
    if (!isCustomerLoaded.value) {
      showTopSnack('No customer selected', isError: true);
      return;
    }
    var shopkeeperId = getBox.read(USER_ID);
    int id = int.tryParse(shopkeeperId.toString()) ?? 0;

    final star = starController.text.trim();
    final coin = coinController.text.trim();
    if (star.isEmpty && coin.isEmpty) {
      showTopSnack('Enter at least one reward value', isError: true);
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
        showTopSnack(
          datam['message'] ?? 'Reward sent successfully',
          isError: false,
        );

        starController.clear();
        coinController.clear();
        shoppingprice.clear();
        proddescription.clear();
        searchController.clear();
      } else {
        showTopSnack(
          datam['message'] ?? 'Failed to assign reward',
          isError: true,
        );
      }
    } catch (e) {
      showTopSnack(e.toString(), isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  void scanQr(String scannedCode) {
    if (isScanned) return;

    isScanned = true;
    searchController.text = scannedCode;
    searchCustomer();
  }
}
