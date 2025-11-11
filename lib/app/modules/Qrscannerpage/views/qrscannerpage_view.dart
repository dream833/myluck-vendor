import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rewardvendor/app/modules/assign_point/controllers/assign_point_controller.dart';

class QrscannerpageView extends StatelessWidget {
  const QrscannerpageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssignPointController>();

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: MobileScannerController(facing: CameraFacing.back),
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              final code = barcode.rawValue;
              if (code != null && code.isNotEmpty) {
                controller.scanQr(code);
                Get.back();
              }
            },
          ),
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Positioned(
            bottom: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "Align the QR code inside the box",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
