import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mychance/screens/feed_screen.dart';
import 'package:mychance/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageId = 2;

  final pages = [
    const Text('Messages'),
    const Text('Trending'),
    const FeedScreen(),
    const Text('Most funded'),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 67,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
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
            iconSize: 25,
            selectedIconTheme: const IconThemeData(size: 29),
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
                      width: pageId == 2 ? 29 : 25,
                      height: pageId == 2 ? 29 : 25,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      'mychance',
                      style: TextStyle(
                          color: pageId == 2
                              ? const Color.fromRGBO(200, 174, 83, 1)
                              : Colors.white),
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