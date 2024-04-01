import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Container(
                  width: 500,
                  height: 700,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color.fromRGBO(153, 127, 38, 1), Colors.white],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        const Text(
                          'TRENDING\nPROJECTS',
                          style: TextStyle(
                            shadows: [
                              Shadow(
                                  blurRadius: 10.0,
                                  color: Colors.white,
                                  offset: Offset(2.0, 2.0))
                            ],
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 450,
                        ),
                        FloatingActionButton.extended(
                          backgroundColor: Colors.white,
                          onPressed: () {},
                          label: const Text(
                            'LOAD MORE',
                            style: TextStyle(
                                color: Color.fromRGBO(153, 127, 38, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (index, context) {
                      return projects(1, 1, false);
                    },
                  ),
                ),
                const SizedBox(
                  height: 190,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget projects(invested, left, unread) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromRGBO(143, 8, 8, 1),
                  ),
                  child: const Center(
                    child: Text(
                      '1.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 80,
              width: 350,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color.fromRGBO(239, 22, 22, 1),
                    Color.fromRGBO(200, 145, 22, 1),
                    Colors.black
                  ],
                ),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: SizedBox(
                            width: 45,
                            height: 45,
                            child: Image.asset(
                              'images/myChanceLogo_white.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 2, right: 30),
                                child: Text(
                                  '@mymind.com',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                            blurRadius: 10.0,
                                            color:
                                                Color.fromRGBO(200, 174, 83, 1),
                                            offset: Offset(2.0, 2.0))
                                      ],
                                      color: Color.fromRGBO(200, 174, 83, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2, right: 70),
                                child: Text(
                                  '134.000 likes',
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                            blurRadius: 10.0,
                                            color:
                                                Color.fromRGBO(200, 174, 83, 1),
                                            offset: Offset(2.0, 2.0))
                                      ],
                                      color: Color.fromRGBO(200, 174, 83, 1),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 70),
                                child: Text(
                                  'active: 41 hrs',
                                  style: TextStyle(
                                    shadows: [
                                      Shadow(
                                          blurRadius: 10.0,
                                          color:
                                              Color.fromRGBO(200, 174, 83, 1),
                                          offset: Offset(2.0, 2.0))
                                    ],
                                    color: Color.fromRGBO(200, 174, 83, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Icon(
                        CupertinoIcons.flame_fill,
                        color: Color.fromRGBO(239, 22, 22, 1),
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
