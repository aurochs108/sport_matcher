import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen.dart';

class CreateProfileScreenModel {
  VoidCallback navigateToHomeAction(NavigatorState navigator) {
    return () => navigator.push(
      MaterialPageRoute(builder: (_) => BottomNavigationBarScreen()),
    );
  }
}
