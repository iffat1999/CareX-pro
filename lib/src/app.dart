import 'package:carex_pro/src/app_state.dart';
import 'package:carex_pro/src/pages/auth/login/login_view.dart';
import 'package:carex_pro/src/pages/dashboard/dashboard_view.dart';
import 'package:carex_pro/src/pages/diet_plan/dietplan_view.dart';
import 'package:carex_pro/src/pages/doctors_page.dart';
import 'package:carex_pro/src/pages/more_pages.dart';

import 'package:flutter/material.dart';

// this should be statefull widget when authentication needed.
class CareXProApp extends StatefulWidget {
  const CareXProApp({super.key});

  @override
  State<CareXProApp> createState() => _CareXProAppState();
}

class _CareXProAppState extends State<CareXProApp> {
  // if user is authorize then show the dashboard page otherwise push to login page.
  final appState = ApplicationState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CareX Pro: AI Health Consultant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: appState.getCurrentUserID() == null ? LoginPage() : MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget currentPage;

    switch (currentIndex) {
      case 0:
        currentPage = const DashboardView();
        break;
      case 1:
        currentPage = const DoctorsPage();
        break;
      case 2:
        currentPage = const DietPlanPage();
        break;
      case 3:
        currentPage = const MorePages();
        break;
      default:
        currentPage = const Text("Default Page");
        break;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.green.shade400,
        unselectedItemColor: Colors.green.shade300,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Doctors",
            icon: Icon(Icons.groups),
          ),
          BottomNavigationBarItem(
            label: "Diet Plan",
            icon: Icon(Icons.fastfood),
          ),
          BottomNavigationBarItem(
            label: "More",
            icon: Icon(Icons.grid_view),
          )
        ],
      ),
    );
  }
}
