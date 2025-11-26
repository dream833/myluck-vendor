import 'package:get/get.dart';

import 'package:rewardvendor/app/data/function/mydio.dart';

class TransactionController extends GetxController {
  var isLoading = false.obs;
  var transactions = [].obs; // store all transaction data
  var message = ''.obs;

  // fetch transactions for given shopkeeper
  Future<void> fetchTransactions({
    required String shopId,
    String? month,
    String? year,
  }) async {
    isLoading.value = true;
    message.value = '';

    try {
      final response = await dioPost(
        endUrl: 'shopkeeper/transaction',
        data: {"shop_id": shopId, "month": month ?? "", "year": year ?? ""},
      );
      var data = response.data;
      if (data['status'] == 200) {
        transactions.value = data['data'];
        message.value = data['message'] ?? 'Record Found';
      } else {
        message.value = data['message'] ?? 'No Record Found';
        transactions.clear();
      }
    } catch (e) {
      message.value = "Error: $e";
      transactions.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
