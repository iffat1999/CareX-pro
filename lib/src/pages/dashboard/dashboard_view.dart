import 'dart:math';
import 'package:carex_pro/src/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String generateSlogan() {
    final slogans = [
      "Your health, our heartfelt commitment.",
      "We care because you matter.",
      "Putting your well-being at the center of all we do.",
      "Health care with heart, just for you.",
      "Your health journey, our dedicated mission.",
      "Caring for you, like family.",
      "Prioritizing your health, always and forever.",
      "Here for your health, every step of the way.",
      "Compassionate care, anytime you need it.",
      "Because your health is our greatest reward.",
    ];

    final random = Random();
    return slogans[random.nextInt(slogans.length)];
  }

  final appState = ApplicationState();

  Future<String> fetchUserFullName() async {
    try {
      final String? userID = appState.getCurrentUserID();
      if (userID == null) {
        return 'No user signed in';
      }
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .get();

      if (userDoc.exists) {
        return userDoc.data()?['fullName'] ?? 'No Name';
      } else {
        return 'User not found';
      }
    } catch (e) {
      return 'Error Fetching data $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: Card(
                color: Colors.green[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                margin: EdgeInsets.all(0),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, top: 8.0, right: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FutureBuilder(
                          future: fetchUserFullName(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              return Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        'assets/images/patient_monogram.png'),
                                  ),
                                  SizedBox(width: 16),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Welcome, ${snapshot.data}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        SizedBox(
                                          width: 250,
                                          child: Text(
                                            generateSlogan(),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.green[50],
                                            ),
                                          ),
                                        ),
                                      ])
                                ],
                              );
                            } else {
                              return const Text("User not found.");
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(
                16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Medical History Section
                  const SectionHeader(title: 'Medical History'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1, // Replace with dynamic count
                    itemBuilder: (context, index) {
                      return const ListTile(
                        leading:
                            Icon(Icons.medical_services, color: Colors.green),
                        title: Text('Blood Test'),
                        subtitle: Text('Date: 7 Jan 2025'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Appointments Section
                  const SectionHeader(title: 'Appointments'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1, // Replace with dynamic count
                    itemBuilder: (context, index) {
                      return const ListTile(
                        leading:
                            Icon(Icons.calendar_today, color: Colors.green),
                        title: Text('Dr Jane Smith'),
                        subtitle: Text('Date: 20 Jan 2025, Time: 10:00 AM'),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Health Records Section
                  const SectionHeader(title: 'Health Records'),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 1, // Replace with dynamic count
                    itemBuilder: (context, index) {
                      return const ListTile(
                        leading: Icon(Icons.file_present, color: Colors.green),
                        title: Text('ECG Report'),
                        subtitle: Text('Uploaded on: 04 Jan 2025'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.green,
        ),
      ),
    );
  }
}
