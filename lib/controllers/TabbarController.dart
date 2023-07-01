import 'package:get/get.dart';

class TabbarController extends GetxController {

  late int? selectedIndex;
  void changeTab(int index) {
    selectedIndex = index;
    update();
    // selectedIndex = null;
  }

}