import 'package:flutter/material.dart';

class HealthRecordsPage extends StatelessWidget {
  const HealthRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records'),
        backgroundColor: Colors.green,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: const Center(child: Text('Health Records Page')),
      backgroundColor: Colors.white,
    );
  }
}
