import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/function/mydio.dart';

class LeaderboardController extends GetxController {
  var leaderboard = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    try {
      isLoading(true);

      final response = await dioGet("leadboard-store-list");

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data["data"] != null) {
        final List data = response.data["data"];

        leaderboard.assignAll(
          data.map((item) {
            return {
              "shop_name": item["shop_name"] ?? "Unknown",
              "likes": item["total_likes"] ?? 0,
              "coins": item["total_coins"] ?? 0,
              "stars": item["total_stars"] ?? 0,
            };
          }).toList(),
        );

        // 🔹 Sort by coins (descending order)
        leaderboard.sort((a, b) => b["coins"].compareTo(a["coins"]));
      } else {
        leaderboard.clear();
      }
    } catch (e) {
      debugPrint("❌ Leaderboard fetch error: $e");
      Get.snackbar(
        "Error",
        "Failed to load leaderboard: $e",
        backgroundColor: const Color(0xFFE57373),
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
