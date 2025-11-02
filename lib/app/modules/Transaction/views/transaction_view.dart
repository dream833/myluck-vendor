import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Month Selector
          Obx(() => DropdownButton<String>(
                value: controller.selectedMonth.value,
                items: controller.months
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (val) {
                  controller.selectedMonth.value = val!;
                  controller.filterByMonth();
                },
              )),

          // Customer List
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.filteredTransactions.length,
                itemBuilder: (context, index) {
                  final txn = controller.filteredTransactions[index];
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person, color: Colors.teal),
                      title: Text(txn["customer"]),
                      subtitle: Text(
                          "Coins: ${txn["coins"]} | Stars: ${txn["stars"]}"),
                      trailing: IconButton(
                        icon:
                            const Icon(Icons.add_circle, color: Colors.teal),
                        onPressed: () {
                          _showAssignDialog(controller, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),

      // Floating Button for new customer
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.person_add),
        onPressed: () {
          _showAddCustomerDialog(controller);
        },
      ),
    );
  }

  void _showAddCustomerDialog(TransactionController controller) {
    final nameCtrl = TextEditingController();

    Get.defaultDialog(
      title: "Add Customer",
      content: TextField(
        controller: nameCtrl,
        decoration: const InputDecoration(hintText: "Enter customer name"),
      ),
      textConfirm: "Add",
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onConfirm: () {
        if (nameCtrl.text.isNotEmpty) {
          controller.addCustomer(nameCtrl.text, controller.selectedMonth.value);
          Get.back();
        }
      },
      textCancel: "Cancel",
    );
  }

  void _showAssignDialog(TransactionController controller, int index) {
    final rewardCtrl = TextEditingController();
    String rewardType = "coin";

    Get.defaultDialog(
      title: "Assign Reward",
      content: Column(
        children: [
          DropdownButton<String>(
            value: rewardType,
            items: const [
              DropdownMenuItem(value: "coin", child: Text("Coin")),
              DropdownMenuItem(value: "star", child: Text("Star")),
            ],
            onChanged: (val) {
              rewardType = val!;
            },
          ),
          TextField(
            controller: rewardCtrl,
            decoration: const InputDecoration(hintText: "Enter value"),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      textConfirm: "Generate Code",
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onConfirm: () {
        final value = int.tryParse(rewardCtrl.text) ?? 0;
        final code = controller.assignReward(index, rewardType, value);
        Get.back();

        // Show final code to user
        Get.defaultDialog(
          title: "Share this Code",
          content: Text("Give this code to customer:\n\n$code",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          buttonColor: Colors.teal,
          onConfirm: () => Get.back(),
        );
      },
      textCancel: "Cancel",
    );
  }
}