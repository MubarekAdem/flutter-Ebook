import 'dart:ffi';
import 'dart:nativewrappers/_internal/vm/lib/ffi_patch.dart';

import 'package:flutter/material.dart';
import 'audio/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
            body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(AssetImage("lib/assets/img/menu.png"),
                      size: 24, color: Colors.black),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.notifications),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child:
                        Text("Popular Books ", style: TextStyle(fontSize: 30)))
              ],
            ),
            Container(
                height: 180,
                child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: 5,
                    itemBuilder: (_, i) {
                      return Container(
                          height: 180,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage("lib/assets/img/pic-8.png"),
                              )));
                    }))
          ],
        )),
      ),
    );
  }
}
