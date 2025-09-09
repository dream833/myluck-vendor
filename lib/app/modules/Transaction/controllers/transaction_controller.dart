import 'dart:math';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var months = ["January", "February", "March", "April"].obs;
  var selectedMonth = "January".obs;

  var transactions = <Map<String, dynamic>>[].obs;
  var filteredTransactions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    addCustomer("Customer 1", "January");
    addCustomer("Customer 2", "January");
    addCustomer("Customer 3", "February");
    filterByMonth();
  }

  void addCustomer(String name, String month) {
    transactions.add({
      "customer": name,
      "bill": 0,
      "coins": 0,
      "stars": 0,
      "month": month,
    });
    filterByMonth();
  }

  void filterByMonth() {
    filteredTransactions.value = transactions
        .where((txn) => txn["month"] == selectedMonth.value)
        .toList();
  }

  /// Reward assign with code generation
  String assignReward(int index, String type, int value) {
    final txn = filteredTransactions[index];
    txn[type == "coin" ? "coins" : "stars"] += value;
    filteredTransactions.refresh();

    // simple random code generator
    String code = "${type.toUpperCase()}-${Random().nextInt(999999)}";

    Get.snackbar("Code Generated", "Share this code: $code");

    return code;
  }
}
