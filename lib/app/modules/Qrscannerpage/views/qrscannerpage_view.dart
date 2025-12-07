import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rewardvendor/app/modules/Qrscannerpage/controllers/qrscannerpage_controller.dart';

class QrscannerpageView extends StatelessWidget {
  QrscannerpageView({super.key});

  final QrscannerController controller = Get.put(QrscannerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                MobileScanner(
                  controller: controller.scannerController,
                  onDetect: controller.onDetect,
                ),
                // 🔲 Highlight box for scan area
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal, width: 3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
