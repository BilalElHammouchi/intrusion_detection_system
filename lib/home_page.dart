import 'package:flutter/material.dart';
import 'package:intrusion_detection_system/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Number of Requests',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '${User.nbrRequests}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildRequestTypeContainer(
                  'BENIGN', Icons.security, '${User.nbrBenign}'),
              buildRequestTypeContainer(
                  'DDoS', Icons.warning, '${User.nbrDDoS}'),
              buildRequestTypeContainer(
                  'PortScan', Icons.error, '${User.nbrPortScan}'),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRequestTypeContainer(String text, IconData icon, String number) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Icon(
                icon,
                size: 32.0,
                color: text != 'BENIGN' ? Colors.red : Colors.green,
              ),
              const SizedBox(height: 8.0),
              Text(
                number,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
