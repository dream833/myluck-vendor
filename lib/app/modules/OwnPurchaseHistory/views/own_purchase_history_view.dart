import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/own_purchase_history_controller.dart';

class OwnPurchaseHistoryView extends StatelessWidget {
  const OwnPurchaseHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OwnPurchaseHistoryController());

    // Fetch data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchPurchaseHistory();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Purchase History"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.purchases.isEmpty) {
          return Center(
            child: Text(
              controller.message.value.isNotEmpty
                  ? controller.message.value
                  : "No purchases found",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchPurchaseHistory,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.purchases.length,
            itemBuilder: (context, index) {
              final item = controller.purchases[index];
              final date = DateFormat(
                'dd MMM yyyy, hh:mm a',
              ).format(DateTime.parse(item['created_at']));

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Icon section
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: item['balance_type'] == 'Coin'
                              ? Colors.orange.withOpacity(0.15)
                              : Colors.purple.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          item['balance_type'] == 'Coin'
                              ? Icons.monetization_on
                              : Icons.star,
                          color: item['balance_type'] == 'Coin'
                              ? Colors.orange
                              : Colors.purple,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['package_title'] ?? 'Unknown Package',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${item['balance_quantity']} ${item['balance_type']}",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "₹${item['price']}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payment,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item['payment_status'] ?? 'Unknown',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: (item['payment_status'] == 'Paid')
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Purchased on $date",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
