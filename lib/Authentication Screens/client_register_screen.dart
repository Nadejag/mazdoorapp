import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientRegisterScreen extends StatefulWidget {
  const ClientRegisterScreen({super.key});

  @override
  State<ClientRegisterScreen> createState() => _ClientRegisterScreenState();
}

class _ClientRegisterScreenState extends State<ClientRegisterScreen> {
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _accountDetailsFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  int _currentStep = 0;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Registration'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep == 0 && !_basicInfoFormKey.currentState!.validate()) {
            return;
          }
          if (_currentStep == 1 && !_accountDetailsFormKey.currentState!.validate()) {
            return;
          }

          if (_currentStep < 2) {
            setState(() => _currentStep++);
          } else {
            _registerUser();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep--);
          } else {
            Navigator.pop(context);
          }
        },
        steps: [
          Step(
            title: const Text('Basic Information'),
            content: Form(
              key: _basicInfoFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Account Details'),
            content: Form(
              key: _accountDetailsFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Location'),
            content: Column(
              children: [
                const Text('Select your location for better service matching'),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    // Simulate location selection
                    // final selectedLocation = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => LocationPickerScreen()),
                    // );
                    // if (selectedLocation != null) {
                    //   setState(() {
                    //     // Save the selected location
                    //   });
                    // }
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text('Select Location on Map'),
                ),
                const SizedBox(height: 20),
                // TODO: Add map preview widget
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _registerUser() async {
    if (!_basicInfoFormKey.currentState!.validate() ||
        !_accountDetailsFormKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Firebase registration
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save additional user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user?.uid).set({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
      });

      // Navigate to home screen after successful registration
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => HomeScreen()),
      // );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}