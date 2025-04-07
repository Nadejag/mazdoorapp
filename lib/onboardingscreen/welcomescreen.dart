import 'package:flutter/material.dart';

import 'package:mazdoortw/onboardingscreen/role_selection_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              const Spacer(),
          Image.asset('assets/images/logo.png', height: 150),
          const SizedBox(height: 30),
          const Text(
            'Connecting You With Trusted Service Providers',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const Text(
            'Find skilled workers or get more jobs with Mazdoor',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RoleSelectionScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
                child: const Text('Get Started'),

            ),

          ),
                const SizedBox(height: 20),],
          ),
        ),
      ),
    );
  }
}