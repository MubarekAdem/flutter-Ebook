import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'audio/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List popularBooks = [];
  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("lib/assets/json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    ReadData();
  }

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
            SizedBox(height: 20),
            Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: Container(
                          height: 180,
                          child: PageView.builder(
                              controller: PageController(viewportFraction: 0.8),
                              itemCount: popularBooks.length,
                              itemBuilder: (_, i) {
                                return Container(
                                    height: 180,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: AssetImage(
                                              popularBooks[i]["img"]),
                                          fit: BoxFit.fill,
                                        )));
                              })),
                    )
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
