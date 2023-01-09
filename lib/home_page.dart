import 'dart:convert';

import 'package:audio_player/app_color/app_color.dart' as AppColors;
import 'package:audio_player/app_tabs.dart';
import 'package:audio_player/detail_audio_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  List? books;
  readData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((value) {
      setState(() {
        books = json.decode(value);
      });
    });
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = TabController(length: 3, vsync: this);
    return Container(
      color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.menu,
                      size: 30,
                    ),
                    Row(
                      children: const [
                        Icon(Icons.search),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.notifications)
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "Popular Books",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                child: Stack(children: [
                  Positioned(
                    left: -20,
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 180,
                      child: PageView.builder(
                          itemCount: 5,
                          controller: PageController(viewportFraction: 0.8),
                          itemBuilder: (_, i) {
                            return Container(
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.greenAccent),
                            );
                          }),
                    ),
                  ),
                ]),
              ),
              Expanded(
                  child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                            SliverAppBar(
                              pinned: true,
                              backgroundColor: AppColors.sliverBachground,
                              bottom: PreferredSize(
                                preferredSize: const Size.fromHeight(50),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, left: 20),
                                  child: TabBar(
                                      indicatorPadding: const EdgeInsets.all(0),
                                      indicatorSize: TabBarIndicatorSize.label,
                                      labelPadding:
                                          const EdgeInsets.only(right: 10),
                                      controller: _tabController,
                                      indicator: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 7,
                                              offset: const Offset(0, 0),
                                            )
                                          ]),
                                      isScrollable: true,
                                      tabs: [
                                        AppTabs(
                                            color: AppColors.menu1Color,
                                            text: "New"),
                                        AppTabs(
                                            color: AppColors.menu2Color,
                                            text: "Popular"),
                                        AppTabs(
                                            color: AppColors.menu3Color,
                                            text: "Trending"),
                                      ]),
                                ),
                              ),
                            )
                          ]),
                      body: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                              itemCount: books == null ? 0 : books!.length,
                              itemBuilder: (_, i) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailAudioPage(booksData: books,index:i)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppColors.tabVarViewColor,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 2,
                                                offset: const Offset(0, 0),
                                                color:
                                                    Colors.grey.withOpacity(0.2))
                                          ]),
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
                                                        books![i]['img']),
                                                    fit: BoxFit.cover)),
                                          ),
                                         const SizedBox(width: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.star,size: 20,color: AppColors.startColor ,),
                                                  const SizedBox(width: 5,),
                                                  Text(books![i]["rating"],style: TextStyle(color: AppColors.menu2Color),)
                                                ],
                                              ),
                                              Text(
                                                
                                                books![i]['title'],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                              Text(books![i]['text'],style:  TextStyle(fontSize: 16,color: AppColors.subTitleText),),
                                              Container(
                                                height: 20, 
                                                width: 60 , 
                                                decoration:  BoxDecoration(
                                                  borderRadius: BorderRadius.circular(3), 
                                                  color:  AppColors.loveColor, 
                                
                                                ),
                                                alignment: Alignment.center,
                                                child: const Text("Love",style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white
                                                ),),
                                              )
                                              
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          const ListTile(
                            leading: CircleAvatar(),
                            title: Text("title"),
                          ),
                          const ListTile(
                            leading: CircleAvatar(),
                            title: Text("title"),
                          )
                        ],
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
