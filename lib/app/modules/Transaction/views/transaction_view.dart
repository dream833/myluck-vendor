import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends StatelessWidget {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TransactionController());
    final box = GetStorage();

    final shopId = box.read(USER_ID)?.toString() ?? '';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (shopId.isNotEmpty) {
        controller.fetchTransactions(shopId: shopId);
      } else {
        controller.message.value = "Shop ID not found!";
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (shopId.isEmpty) {
          return const Center(
            child: Text(
              "No Shop ID found in local storage!",
              style: TextStyle(fontSize: 16, color: Colors.redAccent),
            ),
          );
        }

        if (controller.transactions.isEmpty) {
          return Center(
            child: Text(
              controller.message.value.isNotEmpty
                  ? controller.message.value
                  : "No transactions found",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final txn = controller.transactions[index];
            final date = DateFormat(
              'dd MMM yyyy, hh:mm a',
            ).format(DateTime.parse(txn['created_at']));

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.teal.withOpacity(0.1),
                  child: const Icon(Icons.person, color: Colors.teal),
                ),
                title: Text(
                  txn['customer_name'] ?? 'Unknown Customer',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on,
                          size: 16,
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Coins: ${txn['coin']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          "Stars: ${txn['star']}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Status: ${txn['payment_status']}",
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Date: $date",
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
