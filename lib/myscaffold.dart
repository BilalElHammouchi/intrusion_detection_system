import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intrusion_detection_system/home_page.dart';
import 'package:intrusion_detection_system/requests_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const HomePage(), const RequestsPage()];
  late int delaySeconds, delayMilliseconds;
  late Random random;

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://goldendovah.pythonanywhere.com/get_request'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        print(data['message']);
      });
    } else {
      throw Exception('Failed to load data');
    }
    delaySeconds = random.nextInt(19) + 5;
    delayMilliseconds = delaySeconds * 1000;
    Future.delayed(Duration(milliseconds: delayMilliseconds), fetchData);
  }

  @override
  void initState() {
    random = Random();
    delaySeconds = random.nextInt(19) + 5;
    delayMilliseconds = delaySeconds * 1000;
    Future.delayed(Duration(milliseconds: delayMilliseconds), fetchData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Intrusion Detection System'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: 'Requests',
          ),
        ],
      ),
    );
  }
}
