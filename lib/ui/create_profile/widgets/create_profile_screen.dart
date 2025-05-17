import 'package:flutter/material.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateProfileScreenState();
  }
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create profile"),
          automaticallyImplyLeading: false,
        ),
      ),
    );
  }
}
