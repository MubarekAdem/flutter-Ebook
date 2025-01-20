import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color:AppColors.Background
      child: SafeArea(
        child: Scaffold(),
      ),
    );
  }
}
