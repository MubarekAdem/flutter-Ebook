import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_new/app_tabs.dart';
import 'audio/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List books = [];
  late TabController _tabController;
  late ScrollController _scrollController;

  ReadData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("lib/assets/json/popularBooks.json");
    setState(() {
      popularBooks = json.decode(data);
    });
    String booksData = await DefaultAssetBundle.of(context)
        .loadString("lib/assets/json/books.json");
    setState(() {
      books = json.decode(booksData);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                        backgroundColor: AppColors.silverBackground,
                        floating: true,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 10),
                            child: TabBar(
                              indicatorPadding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.label,
                              labelPadding: const EdgeInsets.only(right: 10),
                              controller: _tabController,
                              isScrollable: true,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: AppColors.background,
                              ),
                              tabs: [
                                AppTabs(
                                    color: AppColors.menu1Color, text: "NEW"),
                                AppTabs(
                                    color: AppColors.menu2Color,
                                    text: "POPULAR"),
                                AppTabs(
                                    color: AppColors.menu3Color,
                                    text: "TRENDING"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                          itemCount: books == null ? 0 : books.length,
                          itemBuilder: (_, i) {
                            return Container(
                              margin: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.tabBarViewColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 2,
                                          offset: Offset(0, 0),
                                        )
                                      ]),
                                  child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: 90,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        books[i]["img"]),
                                                  )))
                                        ],
                                      ))),
                            );
                          }),
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
