import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intrusion_detection_system/home_page.dart';
import 'package:intrusion_detection_system/login_page.dart';
import 'package:intrusion_detection_system/requests_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyScaffold extends StatefulWidget {
  const MyScaffold({super.key});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  List<TextSpan> dynamicText = [];
  List<TextSpan> dynamicRequestText = [];

  int _currentIndex = 0;
  late int delaySeconds, delayMilliseconds;
  late Random random;

  void addText(String s) {
    setState(() {
      dynamicText = [
        ...dynamicText,
        const TextSpan(
          text: 'A ',
          style: TextStyle(color: Colors.black),
        ),
        TextSpan(
          text: s,
          style: TextStyle(color: s == 'Benign' ? Colors.green : Colors.red),
        ),
        const TextSpan(
          text: ' request was received.\n',
          style: TextStyle(color: Colors.black),
        ),
      ];
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      dynamicRequestText = [
        ...dynamicRequestText,
        TextSpan(
          text: '$formattedTime - ',
          style: const TextStyle(color: Colors.black, fontSize: 10),
        ),
        const TextSpan(
          text: 'A ',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
        TextSpan(
          text: s,
          style: TextStyle(
              color: s == 'Benign' ? Colors.green : Colors.red, fontSize: 12),
        ),
        const TextSpan(
          text: ' request was received.\n',
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ];
    });
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://goldendovah.pythonanywhere.com/get_request'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        User.nbrRequests = data['nbr_requests'];
        if (User.nbrBenign != data['nbr_benign']) {
          addText('Benign');
          User.nbrBenign = data['nbr_benign'];
        }
        if (User.nbrDDoS != data['nbr_ddos']) {
          addText('DDoS');
          User.nbrDDoS = data['nbr_ddos'];
        }
        if (User.nbrPortScan != data['nbr_portscan']) {
          addText('PortScan');
          User.nbrPortScan = data['nbr_portscan'];
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
    delaySeconds = random.nextInt(10) + 1;
    delayMilliseconds = delaySeconds * 1000;
    Future.delayed(Duration(milliseconds: delayMilliseconds), fetchData);
  }

  @override
  void initState() {
    random = Random();
    delaySeconds = random.nextInt(10) + 1;
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
      body: _currentIndex == 0
          ? HomePage(textSpan: dynamicText)
          : RequestsPage(
              textSpan: dynamicRequestText,
            ),
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
