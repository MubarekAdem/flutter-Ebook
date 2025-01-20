import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'audio/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  late TabController _tabController;

  Future<void> readData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("lib/assets/json/popularBooks.json");
    setState(() {
      popularBooks = json.decode(data);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              // Top Navigation Bar
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.menu, size: 24, color: Colors.black),
                    Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 10),
                        Icon(Icons.notifications),
                      ],
                    ),
                  ],
                ),
              ),
              // Title Section
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Popular Books",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Popular Books Section
              Container(
                height: 180,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: popularBooks.length,
                  itemBuilder: (_, i) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage(popularBooks[i]["img"]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // TabBar with Tabs
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool isScrolled) {
                    return [
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: Colors.white,
                        floating: true,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.all(0),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.all(0),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: AppColors.background,
                              ),
                              tabs: [
                                Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.menu1Color,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 7,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Text(
                                    "NEW",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.menu2Color,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 7,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Text(
                                    "NEW",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.menu3Color,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 7,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Text(
                                    "NEW",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: const [
                      Material(
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: Text("Content"))),
                      Material(
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: Text("Content"))),
                      Material(
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: Text("Content"))),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
