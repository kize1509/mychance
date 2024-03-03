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
  bool oldProjects = false;
  final PageController pageControllerNew = PageController(initialPage: 0);
  final PageController pageControllerOld = PageController(initialPage: 0);
  int shownProjectNew = 0;
  int shownProjectOld = 0;

  @override
  void initState() {
    myProjectsButtonColor = selectedColor;
    oldProjectsButtonColor = unselectedColor;
    super.initState();
  }

  @override
  void dispose() {
    pageControllerNew.dispose();
    pageControllerOld.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 15, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Icon(Icons.settings),
                            ),
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
                      const Text(
                        '@vargicon',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'entertainment and software',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                    ],
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
                    oldProjects = false;
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
                    oldProjects = true;
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
          Expanded(
            child: oldProjects
                ? PageView.builder(
                    controller: pageControllerOld,
                    onPageChanged: (int page) {
                      setState(() {
                        shownProjectOld = page;
                      });
                    },
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return projectOverview(
                          'OLD PROJECT', '450.000', '450.000', 0, 134, 173);
                    })
                : PageView.builder(
                    controller: pageControllerNew,
                    onPageChanged: (int pageNew) {
                      setState(() {
                        shownProjectNew = pageNew;
                      });
                    },
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return projectOverview('AR GAMING PLATFORM', '300.000',
                          '450.000', 14, 134, 173);
                    }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    oldProjects
                        ? pageControllerOld.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn)
                        : pageControllerNew.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                  },
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: oldProjects
                        ? shownProjectOld == index
                            ? selectedColor
                            : unselectedColor
                        : shownProjectNew == index
                            ? selectedColor
                            : unselectedColor,
                  ),
                ),
              ),
            ),
          ),
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
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget projectOverview(
          projectName, invested, goal, daysLeft, investors, avgInvestment) =>
      Column(
        children: [
          Text(projectName,
              style: TextStyle(
                color: selectedColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          Container(
            margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 19, right: 19, top: 10),
                  width: 500,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromRGBO(201, 186, 131, 1),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 145,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'INVESTED',
                                      style: TextStyle(
                                          color: Color.fromRGBO(16, 79, 150, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      invested + '\$',
                                      style: TextStyle(
                                          color: selectedColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const Text(
                                      'GOAL',
                                      style: TextStyle(
                                          color: Color.fromRGBO(16, 79, 150, 1),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      goal + '\$',
                                      style: TextStyle(
                                          color: selectedColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 145,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 57,
                                      width: 57,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: selectedColor,
                                      ),
                                      child: Center(
                                          child: Text(
                                        daysLeft.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    const Text(
                                      'DAYS LEFT',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 145,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text(
                                      'INVESTORS',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Text(
                                      investors.toString(),
                                      style: TextStyle(
                                          color: selectedColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Container(
                                width: 145,
                                height: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'AVERAGE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const Text(
                                      'INVESTMENT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '$avgInvestment\$',
                                      style: TextStyle(
                                          color: selectedColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
