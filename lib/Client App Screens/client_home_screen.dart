import 'package:flutter/material.dart';

import 'package:mazdoortw/%20Client%20App%20Screens/service_provider_list_screen.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const MessagesTab(),
    const BookingsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mazdoor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to notifications
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          _screens[_currentIndex],
          Positioned(
            bottom: 80, // Adjust based on FAB size and BottomNavigationBar height
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                // TODO: Implement emergency SOS feature
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.emergency, color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search for services...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            onTap: () {
              // TODO: Implement search screen
            },
          ),
          const SizedBox(height: 20),

          // Categories
          const Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            childAspectRatio: 0.8,
            children: [
              _buildCategoryItem(Icons.electrical_services, 'Electrician'),
              _buildCategoryItem(Icons.plumbing, 'Plumber'),
              _buildCategoryItem(Icons.handyman, 'Carpenter'),
              _buildCategoryItem(Icons.format_paint, 'Painter'),
              _buildCategoryItem(Icons.cleaning_services, 'Cleaner'),
              _buildCategoryItem(Icons.ac_unit, 'AC Repair'),
              _buildCategoryItem(Icons.kitchen, 'Appliance'),
              _buildCategoryItem(Icons.local_shipping, 'Movers'),
            ],
          ),
          const SizedBox(height: 20),

          // Popular Near You
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Popular Near You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServiceProviderListScreen(),
                    ),
                  );
                },
                child: const Text('See All'),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildPopularWorkerCard(context),
                _buildPopularWorkerCard(context),
                _buildPopularWorkerCard(context),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Emergency Services
          const Text(
            'Emergency Services',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildEmergencyServiceCard('Electrician', Colors.orange),
                _buildEmergencyServiceCard('Plumber', Colors.blue),
                _buildEmergencyServiceCard('Locksmith', Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPopularWorkerCard(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        child: InkWell(
          onTap: () {
            // TODO: Navigate to worker profile
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/1.jpg',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Ali Khan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Electrician',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    const Text('4.8'),
                    const Spacer(),
                    Text(
                      'PKR 500/hr',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyServiceCard(String service, Color color) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 10),
      child: Card(
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(Icons.emergency, color: color, size: 30),
              const SizedBox(height: 8),
              Text(
                '24/7 $service',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder widgets for other tabs
class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Messages Tab'));
  }
}

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Bookings Tab'));
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Profile Tab'));
  }
}