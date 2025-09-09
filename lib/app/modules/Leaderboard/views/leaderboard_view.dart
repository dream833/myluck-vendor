import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/leaderboard_controller.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeaderboardController());

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Leaderboard"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Selector
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedMonth.value,
                  decoration: InputDecoration(
                    labelText: "Select Month",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                  items: controller.months
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (val) => controller.changeMonth(val!),
                )),
            SizedBox(height: 20.h),

            // Leaderboard Table
            Expanded(
              child: Obx(
                () => Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  elevation: 3,
                  child: Column(
                    children: [
                      // Table Header
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14.r),
                              topRight: Radius.circular(14.r)),
                          gradient: LinearGradient(
                            colors: [Colors.teal, Colors.teal.shade400],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Row(
                          children: [
                            _buildHeaderCell("Rank", flex: 1),
                            _buildHeaderCell("Shopkeeper", flex: 3),
                            _buildHeaderCell("Likes", flex: 2),
                            _buildHeaderCell("Coins", flex: 2),
                          ],
                        ),
                      ),

                      // Table Rows
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.leaderboard.length,
                          separatorBuilder: (_, __) => Divider(height: 1),
                          itemBuilder: (context, index) {
                            final row = controller.leaderboard[index];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 8.w),
                              color: index % 2 == 0
                                  ? Colors.grey.shade50
                                  : Colors.white,
                              child: Row(
                                children: [
                                  _buildCell("${row["rank"]}", flex: 1,
                                      isBold: true),
                                  _buildCell(row["shopkeeper"], flex: 3),
                                  _buildCell("${row["likes"]}", flex: 2),
                                  _buildCell("${row["coins"]}", flex: 2),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style:
            TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCell(String text, {required int flex, bool isBold = false}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
