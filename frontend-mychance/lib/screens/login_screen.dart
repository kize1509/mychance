import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;
  late final TextEditingController _username;
  late final TextEditingController _lozinka;
  String path = "ceca.ddns.net:49500";

  @override
  void initState() {
    _username = TextEditingController();
    _lozinka = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _lozinka.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _username,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required!';
                      }
                      return null;
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusColor: const Color.fromARGB(255, 0, 34, 61),
                      labelText: 'Username',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    controller: _lozinka,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required!';
                      }
                      return null;
                    },
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusColor: const Color.fromARGB(255, 50, 61, 0),
                      labelText: 'Password',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Icon(
                          Icons.key,
                          color: Colors.blue,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: IconButton(
                            icon: obscureText == true
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.blue,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.blue,
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
                const SizedBox(
                  height: 50,
                ),
                FloatingActionButton.extended(
                    label: const Text('Login'),
                    heroTag: 'confirm',
                    onPressed: () async {
                      final credentials = json.encode({
                        "username": _username.text,
                        "password": _lozinka.text,
                      });
                      var response = await post(
                        Uri.http(path, '/user/login'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: credentials,
                      );

                      if (true) {
                        if (response.statusCode == 200) {
                          print('Success');
                        } else {
                          print(response.body);
                        }
                      }
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
