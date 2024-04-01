import 'package:flutter/material.dart';

class MessangerScreen extends StatefulWidget {
  const MessangerScreen({super.key});

  @override
  State<MessangerScreen> createState() => _MessangerScreenState();
}

class _MessangerScreenState extends State<MessangerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 22, right: 22),
            child: Container(
              width: 500,
              height: 600,
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
                      'CHAT BUSINESS',
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
                      height: 85,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (index, context) {
                          return chat(true);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: 150,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color.fromRGBO(153, 127, 38, 1),
                  Color.fromRGBO(219, 212, 187, 1)
                ],
              ),
            ),
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'NEW CHAT',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chat(unread) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 80,
        width: 330,
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
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 10, right: 100),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Text(
                      'Mark',
                      style: TextStyle(
                          color: Color.fromRGBO(200, 174, 83, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 28),
                      child: Text(
                        '@mychance',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                            height: 32,
                            width: 32,
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
                            'unread',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'messages',
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
