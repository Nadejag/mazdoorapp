import 'package:flutter/material.dart';


class ServiceProviderListScreen extends StatefulWidget {
  const ServiceProviderListScreen({super.key});

  @override
  State<ServiceProviderListScreen> createState() =>
      _ServiceProviderListScreenState();
}

class _ServiceProviderListScreenState extends State<ServiceProviderListScreen> {
  String _selectedCategory = 'All';
  String _selectedFilter = 'Rating';

  final List<Map<String, dynamic>> _workers = [
    {
      'name': 'Ali Khan',
      'service': 'Electrician',
      'rating': 4.8,
      'distance': 2.5,
      'rate': 500,
      'image': 'https://randomuser.me/api/portraits/men/1.jpg',
    },
    {
      'name': 'Ahmed Raza',
      'service': 'Plumber',
      'rating': 4.5,
      'distance': 3.2,
      'rate': 400,
      'image': 'https://randomuser.me/api/portraits/men/2.jpg',
    },
    {
      'name': 'Usman Malik',
      'service': 'Carpenter',
      'rating': 4.7,
      'distance': 1.8,
      'rate': 450,
      'image': 'https://randomuser.me/api/portraits/men/3.jpg',
    },
    {
      'name': 'Zain Abbas',
      'service': 'Painter',
      'rating': 4.3,
      'distance': 5.0,
      'rate': 350,
      'image': 'https://randomuser.me/api/portraits/men/4.jpg',
    },
    {
      'name': 'Bilal Ahmed',
      'service': 'AC Technician',
      'rating': 4.9,
      'distance': 2.1,
      'rate': 600,
      'image': 'https://randomuser.me/api/portraits/men/5.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Providers'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Category Filter
                SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryChip('All'),
                      _buildCategoryChip('Electrician'),
                      _buildCategoryChip('Plumber'),
                      _buildCategoryChip('Carpenter'),
                      _buildCategoryChip('Painter'),
                      _buildCategoryChip('AC Technician'),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Sort Filter
                Row(
                  children: [
                    const Text('Sort by:'),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: _selectedFilter,
                      items: const [
                        DropdownMenuItem(
                          value: 'Rating',
                          child: Text('Rating'),
                        ),
                        DropdownMenuItem(
                          value: 'Distance',
                          child: Text('Distance'),
                        ),
                        DropdownMenuItem(
                          value: 'Price',
                          child: Text('Price'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _selectedFilter = value!);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _workers.length,
              itemBuilder: (context, index) {
                final worker = _workers[index];
                return _buildWorkerCard(worker);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(category),
        selected: _selectedCategory == category,
        onSelected: (selected) {
          setState(() => _selectedCategory = category);
        },
      ),
    );
  }

  Widget _buildWorkerCard(Map<String, dynamic> worker) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ServiceProviderDetailScreen(worker: worker),
          //   ),
          // );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(worker['image']),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      worker['service'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(' ${worker['rating']}'),
                        const SizedBox(width: 16),
                        const Icon(Icons.location_on, size: 16),
                        Text(' ${worker['distance']} km'),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    'PKR ${worker['rate']}/hr',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         ServiceProviderDetailScreen(worker: worker),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('Book'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}