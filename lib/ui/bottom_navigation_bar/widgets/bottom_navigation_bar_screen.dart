import 'package:flutter/material.dart';
import 'package:sport_matcher/ui/bottom_navigation_bar/widgets/bottom_navigation_bar_screen_model.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final BottomNavigationBarScreenModel _viewModel;

  BottomNavigationBarScreen({super.key})
      : _viewModel = BottomNavigationBarScreenModel();

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationBarScreen();
  }
}

class _BottomNavigationBarScreen extends State<BottomNavigationBarScreen> {
  @override
  void initState() {
    super.initState();
    widget._viewModel.onStateChanged = () {
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: const Center(child: Text("")),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_gymnastics),
              label: 'Matcher',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Profile',
            ),
          ],
          currentIndex: widget._viewModel.currentIndex.index,
          selectedItemColor: Colors.blue,
          onTap: widget._viewModel.onItemTapped,
        ),
      ),
    );
  }
}
