import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mychance/screens/feed_screen.dart';
import 'package:mychance/screens/messanger_screen.dart';
import 'package:mychance/screens/most_funded_screen.dart';
import 'package:mychance/screens/profile_screen.dart';
import 'package:mychance/screens/trending_screen.dart';

class MainScreen extends StatefulWidget {
  final int startupPage;

  const MainScreen({super.key, required this.startupPage});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageId = 2;

  @override
  void initState() {
    super.initState();
    pageId = widget.startupPage;
  }

  final pages = [
    const MessangerScreen(),
    const TrendingScreen(),
    const FeedScreen(),
    const MostFundedScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 56,
        decoration: const BoxDecoration(color: Colors.black),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            border: Border(
                top: BorderSide(
              color: Colors.white,
            )),
            color: Colors.black,
          ),
          child: BottomNavigationBar(
            onTap: (id) {
              setState(() {
                pageId = id;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            selectedItemColor: const Color.fromRGBO(200, 174, 83, 1),
            unselectedItemColor: Colors.white,
            iconSize: 32,
            selectedIconTheme: const IconThemeData(size: 36),
            unselectedFontSize: 0,
            unselectedLabelStyle: const TextStyle(height: 0),
            currentIndex: pageId,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_text),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.flame),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Image.asset(
                      'images/myChanceLogo_black1.png',
                      width: pageId == 2 ? 24 : 22,
                      height: pageId == 2 ? 24 : 22,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'mychance',
                      style: TextStyle(
                          color: pageId == 2
                              ? const Color.fromRGBO(200, 174, 83, 1)
                              : Colors.white,
                          fontSize: 10),
                    )
                  ],
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '',
              ),
            ],
          ),
        ),
      ),
      body: pages[pageId],
    );
  }
}
