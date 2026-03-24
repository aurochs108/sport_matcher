import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';

class CreateProfileScreenModel {
  void navigateToHomeAction(NavigatorState navigator) {
    navigator.push(
      MaterialPageRoute(builder: (_) => BottomNavigationBarScreen()),
    );
  }
}
