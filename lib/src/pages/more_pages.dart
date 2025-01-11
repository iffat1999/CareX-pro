import 'package:carex_pro/src/pages/appointments_page.dart';
import 'package:carex_pro/src/pages/bmi_calculator/bmicalculator_view.dart';
import 'package:carex_pro/src/pages/healthrecord_page.dart';
import 'package:carex_pro/src/pages/medicalhistory_page.dart';
import 'package:carex_pro/src/pages/medicinelist_page.dart';
import 'package:flutter/material.dart';

class MorePages extends StatelessWidget {
  const MorePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.green.shade300,
      //   title: const Text(
      //     "CareX Pro",
      //     style: TextStyle(fontSize: 16, color: Colors.white),
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCard(
              context,
              title: 'Medical History',
              icon: Icons.history,
              color: Colors.green.shade400,
              page: const MedicalHistoryPage(),
            ),
            _buildCard(
              context,
              title: 'Appointments',
              icon: Icons.calendar_today,
              color: Colors.green.shade400,
              page: const AppointmentsPage(),
            ),
            _buildCard(
              context,
              title: 'Health Records',
              icon: Icons.file_present,
              color: Colors.green.shade400,
              page: const HealthRecordsPage(),
            ),
            _buildCard(
              context,
              title: 'Medicine',
              icon: Icons.bloodtype_outlined,
              color: Colors.green.shade400,
              page: const MedicineListPage(),
            ),
            _buildCard(
              context,
              title: 'BMI Calculator',
              icon: Icons.calculate,
              color: Colors.green.shade400,
              page: const BmiCalculatorPage(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required Widget page,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 1,
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
