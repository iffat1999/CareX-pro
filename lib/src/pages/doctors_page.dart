import 'package:flutter/material.dart';

class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = [
      {
        'name': 'Dr. John Doe',
        'designation': 'Cardiologist',
        'details': 'Experienced in heart surgeries and treatments.'
      },
      {
        'name': 'Dr. Jane Smith',
        'designation': 'Neurologist',
        'details': 'Specialist in neurological disorders.'
      },
      {
        'name': 'Dr. Emily Johnson',
        'designation': 'Pediatrician',
        'details': 'Child healthcare expert.'
      },
      {
        'name': 'Dr. Mark Lee',
        'designation': 'Dermatologist',
        'details': 'Skincare and cosmetic procedures.'
      },
      {
        'name': 'Dr. Sarah Brown',
        'designation': 'Orthopedic',
        'details': 'Bone and joint care expert.'
      },
      {
        'name': 'Dr. Richard Davis',
        'designation': 'Psychiatrist',
        'details': 'Mental health and wellness.'
      },
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Doctors",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.green.shade400,
        ),
        body: ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];

              return DoctorCard(
                name: doctor['name']!,
                designation: doctor['designation']!,
                details: doctor['details']!,
              );
            }));
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String designation;
  final String details;

  const DoctorCard({
    required this.name,
    required this.designation,
    required this.details,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: ListTile(
        title: Text(name, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(designation),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.video_call),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Video call with $name')),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Audio call with $name')),
                );
              },
            ),
          ],
        ),
        onTap: () {
          showDoctorDetails(context);
        },
      ),
    );
  }

  void showDoctorDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(designation, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(details, style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.close),
                label: const Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
