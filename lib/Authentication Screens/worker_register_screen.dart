import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For document upload
import 'dart:io'; // For File handling

class WorkerRegisterScreen extends StatefulWidget {
  const WorkerRegisterScreen({super.key});

  @override
  State<WorkerRegisterScreen> createState() => _WorkerRegisterScreenState();
}

class _WorkerRegisterScreenState extends State<WorkerRegisterScreen> {
  final _basicInfoFormKey = GlobalKey<FormState>();
  final _accountDetailsFormKey = GlobalKey<FormState>();
  final _verificationFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _experienceController = TextEditingController();
  final _hourlyRateController = TextEditingController();

  int _currentStep = 0;
  bool _isLoading = false;

  List<String> _selectedSkills = [];
  List<String> _availableSkills = [
    'Electrical Wiring',
    'Plumbing',
    'Carpentry',
    'Painting',
    'AC Repair',
    'Appliance Repair',
    'Cleaning',
    'Moving',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _experienceController.dispose();
    _hourlyRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Worker Registration'),
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
            _registerWorker();
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _experienceController,
                    decoration: const InputDecoration(
                      labelText: 'Years of Experience',
                      prefixIcon: Icon(Icons.work),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your years of experience';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _hourlyRateController,
                    decoration: const InputDecoration(
                      labelText: 'Hourly Rate',
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your hourly rate';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Select your skills:'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _availableSkills.map((skill) {
                      return FilterChip(
                        label: Text(skill),
                        selected: _selectedSkills.contains(skill),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedSkills.add(skill);
                            } else {
                              _selectedSkills.remove(skill);
                            }
                          });
                        },
                      );
                    }).toList(),
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
                      labelText: 'Email (Optional)',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                ],
              ),
            ),
          ),
          Step(
            title: const Text('Verification'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Upload documents for verification:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text('• CNIC Front Side'),
                const Text('• CNIC Back Side'),
                const Text('• Work Samples (Optional)'),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    // Example: Use image_picker to upload documents
                    final picker = ImagePicker();
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      // Handle uploaded file
                      print('Uploaded file: ${pickedFile.path}');
                    }
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Upload Documents'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Note: Your account will be activated after verification, which may take up to 24 hours.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _registerWorker() async {
    if (!_basicInfoFormKey.currentState!.validate() ||
        !_accountDetailsFormKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Implement Firebase registration
      // await FirebaseAuth.instance.createUserWithEmailAndPassword(...)

      // Save additional worker details to Firestore
      // await FirebaseFirestore.instance.collection('workers').doc(userCredential.user?.uid).set({...});

      // Navigate to home after successful registration

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (_) => const HomeScreen()),
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