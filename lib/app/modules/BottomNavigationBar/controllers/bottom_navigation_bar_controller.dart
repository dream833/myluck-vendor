import 'package:get/get.dart';

class BottomnavigationbarController extends GetxController {
  //TODO: Implement BottomnavigationbarController

   var currentIndex = 0.obs;
 var isLoading =true.obs;
 @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
