// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  Future<bool> signIn() async {
    final url = Uri.parse('https://goldendovah.pythonanywhere.com/login');

    try {
      final response = await http.post(
        url,
        body: {
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        User.username = usernameController.text;
        final data = json.decode(response.body);
        User.nbrRequests = data['nbr_requests'];
        User.nbrBenign = data['nbr_benign'];
        User.nbrDDoS = data['nbr_ddos'];
        User.nbrPortScan = data['nbr_portscan'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Intrusion Detection System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Center(
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: usernameController,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              icon: Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          TextField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              icon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (await signIn()) {
                                ElegantNotification.success(
                                  title: const Text("Success"),
                                  description: Text(
                                      "Welcome ${usernameController.text}"),
                                ).show(context);
                                Navigator.pushNamed(context, '/index');
                              } else {
                                ElegantNotification.error(
                                  title: const Text("Error"),
                                  description: const Text(
                                      "No administrator found with these credentials."),
                                ).show(context);
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child: const Text('Sign In'),
                          ),
                        ],
                      ),
                    ),
                    _isLoading
                        ? const LinearProgressIndicator()
                        : const SizedBox()
                  ],
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'SDSI S2',
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  static late String username;
  static late int nbrRequests;
  static late int nbrBenign;
  static late int nbrDDoS;
  static late int nbrPortScan;
}
