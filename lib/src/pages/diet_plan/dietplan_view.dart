import 'dart:convert';

import 'package:carex_pro/src/pages/diet_plan/dietplan_controller.dart';
import 'package:carex_pro/src/pages/diet_plan/dietplan_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_markdown/flutter_markdown.dart';

class DietPlanPage extends StatefulWidget {
  const DietPlanPage({super.key});

  @override
  State<DietPlanPage> createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {
  final _formKey = GlobalKey<FormState>();

  final DietplanController controller = DietplanController();
  final DietplanService dietplanService = DietplanService();

  Future<void> generateDietPlan() async {
    setState(() {
      controller.isLoading = true;
    });

    try {
      // Get input from the form and generate the diet plan.
      final response = await dietplanService.postDietPlan(
        prompt: controller.generatePrompt(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['response'] != null && data['response'] is String) {
          controller.dietPlan = data['response'];

          // Navigate to the GeneratedDietPlan page
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => GeneratedDietPlan(
                  patentName: controller.name,
                  dietPlan: controller.dietPlan,
                ),
              ),
            );
          }
        } else {
          controller.dietPlan =
              'Diet plan could not be generated. Please try again.';
        }
      } else {
        controller.dietPlan =
            'Failed to generate diet plan. Error: ${response.statusCode}';
      }
    } catch (e) {
      controller.dietPlan = 'An error occurred: $e';
    } finally {
      setState(() {
        controller.isLoading = false; // Hide the spinner
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Diet Plan",
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade400,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: "Name"),
                            onSaved: (value) => controller.name = value!,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: "Age"),
                            keyboardType: TextInputType.number,
                            onSaved: (value) =>
                                controller.age = int.parse(value!),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your age";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          DropdownButtonFormField<String>(
                            value: controller.gender,
                            items: ['Male', 'Female', 'Other']
                                .map((gender) => DropdownMenuItem(
                                    value: gender, child: Text(gender)))
                                .toList(),
                            onChanged: (value) => setState(() {
                              controller.gender = value!;
                            }),
                            decoration:
                                const InputDecoration(labelText: 'Gender'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(labelText: "BMI"),
                            keyboardType: TextInputType.number,
                            onSaved: (value) =>
                                controller.bmi = double.parse(value!),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your bmi";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CheckboxListTile(
                            title: const Text("I have diabetes"),
                            value: controller.hasDiabetes,
                            onChanged: (value) => setState(() {
                              controller.hasDiabetes = value!;
                            }),
                          ),
                          // Show extra fields if "hasDiabetes" is checked
                          if (controller.hasDiabetes)
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Blood Glucose Level (mg/dL)',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) => controller
                                        .glucoseLevel = int.parse(value!),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your glucose level";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'HbA1c (%)',
                                    ),
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) {
                                      // Check for null or empty before parsing
                                      controller.hba1c =
                                          (value != null && value.isNotEmpty)
                                              ? int.tryParse(value)
                                              : null;
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Current Medications',
                                    ),
                                    onSaved: (value) {
                                      controller.currentMedications =
                                          value ?? '';
                                    },
                                  ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                          CheckboxListTile(
                            title: const Text("I have high blood pressure"),
                            value: controller.hasBP,
                            onChanged: (value) => setState(() {
                              controller.hasBP = value!;
                            }),
                          ),
                          // if "hasBP" is checked
                          if (controller.hasBP) ...[
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Systolic Pressure (mmHg)',
                              ),
                              keyboardType: TextInputType.number,
                              onSaved: (value) =>
                                  controller.sysPressure = int.parse(value!),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your Systolic Pressure!";
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Diastolic Pressure (mmHg)',
                              ),
                              keyboardType: TextInputType.number,
                              onSaved: (value) => controller.diastolicPressure =
                                  int.parse(value!),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your Systolic Pressure!";
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                          const SizedBox(
                            height: 16,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 16),
                              ),
                              onPressed: controller.isLoading
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        generateDietPlan();
                                      }
                                    },
                              child: controller.isLoading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      "Generate Diet Plan",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratedDietPlan extends StatelessWidget {
  const GeneratedDietPlan({
    super.key,
    required this.patentName,
    required this.dietPlan,
  });

  final String dietPlan;
  final String patentName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$patentName's Diet Plan",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade400,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 800,
          child: Markdown(
            data: dietPlan,
            selectable: true,
            styleSheet: MarkdownStyleSheet(
              h2: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              p: const TextStyle(fontSize: 16, height: 1.5),
              listBullet: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
