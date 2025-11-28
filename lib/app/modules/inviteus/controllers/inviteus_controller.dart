import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rewardvendor/app/data/config/app_config.dart';
import 'package:share_plus/share_plus.dart';

class InviteusController extends GetxController {
  //TODO: Implement InviteusController

  final count = 0.obs;

  final referralCode = (getBox.read(REFERRAL_CODE) ?? "").toString().obs;

  void copyCode() async {
    if (referralCode.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: referralCode.value));
    Get.snackbar("Copied", "Referral code copied to clipboard!");
  }

  void shareCode() {
    if (referralCode.isEmpty) return;
    Share.share(
      "🎁 Use my referral code ${referralCode.value} to join the app and earn rewards!",
      subject: "Join using my referral code!",
    );
  }
}
