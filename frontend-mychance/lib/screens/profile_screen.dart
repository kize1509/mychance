import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Color selectedColor = const Color.fromRGBO(201, 186, 131, 1);
  final Color unselectedColor = const Color.fromRGBO(159, 158, 158, 1);
  Color myProjectsButtonColor = Colors.grey;
  Color oldProjectsButtonColor = Colors.grey;

  @override
  void initState() {
    myProjectsButtonColor = selectedColor;
    oldProjectsButtonColor = unselectedColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 500,
                  height: 230,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color.fromRGBO(153, 127, 38, 1), Colors.white],
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        '@vargicon',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 0),
                      Text(
                        'entertainment and software',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: ClipOval(
                    child: SizedBox(
                      width: 110,
                      height: 110,
                      child: Image.asset(
                        'images/myChanceLogo_white.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 100,
              right: 100,
              top: 10,
            ),
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    myProjectsButtonColor = selectedColor;
                    oldProjectsButtonColor = unselectedColor;
                  });
                },
                child: Text(
                  'MY PROJECTS',
                  style: TextStyle(
                    color: myProjectsButtonColor,
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    oldProjectsButtonColor = selectedColor;
                    myProjectsButtonColor = unselectedColor;
                  });
                },
                child: Text(
                  'OLD PROJECTS',
                  style: TextStyle(
                    color: oldProjectsButtonColor,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 300),
          Container(
            margin: const EdgeInsets.only(
              left: 100,
              right: 100,
              top: 10,
              bottom: 10,
            ),
            height: 8,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            width: 100,
            height: 75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(153, 127, 38, 1),
                  Color.fromRGBO(197, 188, 154, 1)
                ],
              ),
            ),
            child: TextButton(
              onPressed: () {},
              child: const Icon(
                CupertinoIcons.lightbulb,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
