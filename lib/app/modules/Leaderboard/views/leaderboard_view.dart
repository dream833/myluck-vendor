import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderboardController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Leaderboard"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 2,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        }

        if (controller.leaderboard.isEmpty) {
          return const Center(
            child: Text(
              "No leaderboard data found.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchLeaderboard,
          color: Colors.teal,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 8.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      _buildHeaderCell("Rank", flex: 2),
                      _buildHeaderCell("Shop", flex: 3),
                      _buildHeaderCell("Likes", flex: 2),
                      _buildHeaderCell("Coins", flex: 2),
                      _buildHeaderCell("Stars", flex: 2),
                    ],
                  ),
                ),
                SizedBox(height: 6.h),
                ...List.generate(controller.leaderboard.length, (index) {
                  final data = controller.leaderboard[index];
                  final rank = index + 1;

                  Color rowColor;
                  if (rank == 1) {
                    rowColor = Colors.amber.shade100;
                  } else if (rank == 2) {
                    rowColor = Colors.grey.shade200;
                  } else if (rank == 3) {
                    rowColor = Colors.brown.shade100;
                  } else {
                    rowColor = Colors.white;
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 8.w,
                    ),
                    decoration: BoxDecoration(
                      color: rowColor,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.teal.shade100),
                    ),
                    child: Row(
                      children: [
                        _buildCell("$rank", flex: 1, align: TextAlign.center),
                        _buildCell(data["shop_name"], flex: 3),
                        _buildCell("${data["likes"]}", flex: 2),
                        _buildCell("${data["coins"]}", flex: 2),
                        _buildCell("${data["stars"]}", flex: 2),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 🔹 Normal Cell (Row Content)
  Widget _buildCell(
    String text, {
    int flex = 1,
    TextAlign align = TextAlign.center,
  }) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
