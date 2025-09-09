import 'package:get/get.dart';

class LeaderboardController extends GetxController {
  var months = ["January", "February", "March", "April"].obs;
  var selectedMonth = "January".obs;

  var leaderboard = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLeaderboard();
  }

  void loadLeaderboard() {
    // Dummy data (normally API call here)
    leaderboard.value = List.generate(10, (index) {
      return {
        "rank": index + 1,
        "shopkeeper": "Shopkeeper ${index + 1}",
        "likes": (100 - index * 5),
        "coins": (500 - index * 20),
      };
    });
  }

  void changeMonth(String month) {
    selectedMonth.value = month;
    loadLeaderboard(); 
  }
}
