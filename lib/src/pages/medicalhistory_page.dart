import 'package:flutter/material.dart';

class MedicalHistoryPage extends StatelessWidget {
  const MedicalHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
        backgroundColor: Colors.green,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: const Center(child: Text('Medical History Page')),
      backgroundColor: Colors.white,
    );
  }
}
