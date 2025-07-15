import 'package:sport_matcher/ui/bottom_navigation_bar_screen/logic/tab_item.dart';

class BottomNavigationBarScreenModel {
  var currentIndex = TabItem.matcher;

  Function()? onStateChanged;

  void onItemTapped(int index) {
    currentIndex = TabItem.values[index];
    onStateChanged?.call();
  }
}
