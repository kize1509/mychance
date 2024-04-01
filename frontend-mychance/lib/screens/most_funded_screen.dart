import 'package:flutter/material.dart';

class MostFundedScreen extends StatefulWidget {
  const MostFundedScreen({super.key});

  @override
  State<MostFundedScreen> createState() => _MostFundedScreenState();
}

class _MostFundedScreenState extends State<MostFundedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
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
                      'MOST FUNDED\nPROJECTS',
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
                      textAlign: TextAlign.center,
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
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (index, context) {
                      return projects(900000, 1500000, true);
                    },
                  ),
                ),
              ],
            ), //projects(900000, 1500000, true),
          )
        ],
      ),
    );
  }

  Widget projects(invested, left, unread) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 80,
        width: 430,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
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
                  backgroundColor: Colors.grey[200],
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
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5, right: 100),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 2, right: 30),
                          child: Text(
                            '@mychance',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Color.fromRGBO(200, 174, 83, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                          width: 150,
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: LinearProgressIndicator(
                              value: invested / left,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Text(
                            '900.000/1.500.000 \$',
                            style: TextStyle(
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
              unread
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Column(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color.fromRGBO(200, 174, 83, 1),
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'days left',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
}
