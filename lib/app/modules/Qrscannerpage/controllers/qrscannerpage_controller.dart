import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrscannerController extends GetxController {
  MobileScannerController scannerController = MobileScannerController();
  RxString scannedText = ''.obs;
  bool _isScanCompleted = false;

  void onDetect(BarcodeCapture capture) {
    if (_isScanCompleted) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String code = barcodes.first.rawValue ?? '';
      if (code.isNotEmpty) {
        scannedText.value = code;
        _isScanCompleted = true;

        // Return value to previous page
        Future.delayed(const Duration(milliseconds: 200), () {
          Get.back(result: code);
        });
      }
    }
  }

  @override
  void onClose() {
    scannerController.dispose();
    super.onClose();
  }
}
