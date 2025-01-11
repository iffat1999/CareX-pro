import 'package:carex_pro/src/app.dart';
import 'package:carex_pro/src/pages/auth/login/login_view.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  DateTime? dateOfBirth;
  String? _gender;

  String confirmPassword = "";
  bool? isCheckedTermsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.green[500],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "To get started, Fillout this form",
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Full Name TextField
                      TextFormField(
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: "Full Name",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[800],
                              ),
                              children: [
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                )
                              ],
                            ),
                          ),
                          labelStyle: TextStyle(fontSize: 14.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        controller: _fullNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Full Name is Required";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Email TextField
                      TextFormField(
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: "Email",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[800],
                              ),
                              children: [
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                )
                              ],
                            ),
                          ),
                          labelStyle: TextStyle(fontSize: 14.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is Required";
                          }

                          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

                          if (!emailRegex.hasMatch(value)) {
                            return "Enter a valid email address";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Password TextField
                      TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: "Password",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[800],
                              ),
                              children: [
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                )
                              ],
                            ),
                          ),
                          labelStyle: TextStyle(fontSize: 14.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Confirm Password TextField
                      TextFormField(
                        controller: _confirmPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          label: RichText(
                            text: TextSpan(
                              text: "Confirm Password",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[800],
                              ),
                              children: [
                                TextSpan(
                                  text: "*",
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                )
                              ],
                            ),
                          ),
                          labelStyle: TextStyle(fontSize: 14.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm Password is required";
                          }

                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          if (value != _passwordController.text.trim()) {
                            return "Password doesn't match";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      InputDatePickerFormField(
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                        fieldLabelText: "Date of Birth",
                        keyboardType: TextInputType.datetime,
                        onDateSubmitted: (value) {
                          setState(() {
                            dateOfBirth = value;
                          });
                        },
                        onDateSaved: (value) {
                          setState(() {
                            dateOfBirth = value;
                          });
                        },
                        errorFormatText: 'Invalid format. Use MM/DD/YYYY.',
                        errorInvalidText: 'Date is out of range.',
                        initialDate: DateTime(2000),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _gender = "Male";
                              });
                            },
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Male", // Male value
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                ),
                                const Text("Male"),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _gender = "Female";
                              });
                            },
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Female",
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                ),
                                const Text("Female"),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _gender = "Other";
                              });
                            },
                            child: Row(
                              children: [
                                Radio<String>(
                                  value: "Other", // Others value
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  },
                                ),
                                const Text("Others"),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      InkWell(
                        onTap: () {
                          setState(() {
                            isCheckedTermsAndConditions =
                                !isCheckedTermsAndConditions!;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: isCheckedTermsAndConditions,
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedTermsAndConditions = value;
                                  });
                                }),
                            const Text("I accept the Terms and Conditions."),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Sign Up Button
                      Center(
                        child: ElevatedButton(
                          onPressed: _registerUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 28, vertical: 16),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to sign-up screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create a new user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // await userCredential.user!
        //     .updateDisplayName(_fullNameController.text.trim());

        // Save additional user info to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'fullName': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
          'dob': dateOfBirth.toString(),
          'gender': _gender,
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User registered successfully')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
        ); // Navigate back or to another screen
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }
}
