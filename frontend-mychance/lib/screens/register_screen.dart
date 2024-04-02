import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mychance/screens/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  late final TextEditingController _username;
  late final TextEditingController _password;
  String path = "ceca.ddns.net:49500";

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 47),
                child: Container(
                  width: 300,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black,
                        Color.fromRGBO(200, 145, 22, 1),
                      ],
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 215),
                child: Stack(
                  children: [
                    Container(
                      width: 140,
                      height: 350,
                      margin: const EdgeInsets.only(left: 20, top: 48),
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black,
                            Color.fromRGBO(200, 145, 22, 1),
                          ],
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30, top: 402),
                      child: const Text(
                        'PROFILE PICTURE',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 80,
                      margin: const EdgeInsets.only(left: 20, top: 48),
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black,
                            Color.fromRGBO(200, 145, 22, 1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: '',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: const Text(
                        'NAME OR\nCOMPANY NAME',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 310),
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 80,
                      margin: const EdgeInsets.only(left: 20, top: 28),
                      padding: const EdgeInsets.only(left: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black,
                            Color.fromRGBO(200, 145, 22, 1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _username,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: '',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: const Text(
                        'EMAIL',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 450),
                child: Stack(
                  children: [
                    Container(
                      width: 200,
                      height: 80,
                      margin: const EdgeInsets.only(left: 20, top: 28),
                      padding:
                          const EdgeInsets.only(left: 20, bottom: 20, top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black,
                            Color.fromRGBO(200, 145, 22, 1),
                          ],
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _password,
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: obscureText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: '',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: IconButton(
                                  icon: obscureText == true
                                      ? const Icon(
                                          Icons.visibility_off,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.visibility,
                                          color: Colors.white,
                                        ),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  }),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: const Text(
                        'PASSWORD',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final credentials = json.encode({
                    "username": _username.text,
                    "password": _password.text,
                  });
                  var response = await post(
                    Uri.http(path, '/user/register'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: credentials,
                  );

                  if (response.statusCode == 200) {
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const MainScreen(
                              startupPage: 2,
                            );
                          },
                        ),
                      );
                    }
                  } else {
                    if (mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Data you entered is not valid!'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'))
                          ],
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  width: 160,
                  height: 75,
                  margin: const EdgeInsets.only(top: 650, left: 115),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(153, 127, 38, 1),
                        Colors.white,
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'REGISTER',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
