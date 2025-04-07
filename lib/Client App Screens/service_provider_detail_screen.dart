import 'package:flutter/material.dart';


class ServiceProviderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> worker;

  const ServiceProviderDetailScreen({super.key, required this.worker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(worker['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(
                  image: NetworkImage(worker['image']),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${worker['rating']} (24 reviews)',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              worker['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              worker['service'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '${worker['distance']} km from you',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            'PKR ${worker['rate']}/hr',
                            style: const TextStyle(
                              fontSize: 18,
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
                              //         BookingScreen(worker: worker),
                              //   ),
                              // );
                            },
                            child: const Text('Book Now'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // About
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Experienced professional with 5+ years in the field. Specialized in residential and commercial services. Certified and insured.',
                  ),
                  const SizedBox(height: 20),
                  // Services
                  const Text(
                    'Services Offered',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildServiceChip('Electrical Wiring'),
                      _buildServiceChip('Switch Installation'),
                      _buildServiceChip('Light Fixtures'),
                      _buildServiceChip('Circuit Breaker'),
                      _buildServiceChip('Wiring Inspection'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Availability
                  const Text(
                    'Availability',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: Row(
                      children: [
                        _buildDayChip(context, 'Monday', true),
                        _buildDayChip(context, 'Tuesday', false),
                        _buildDayChip(context, 'Wednesday', true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Gallery
                  const Text(
                    'Work Gallery',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildGalleryImage(
                            'https://images.unsplash.com/photo-1593642632823-8f785ba67e45'),
                        _buildGalleryImage(
                            'https://images.unsplash.com/photo-1633356122544-f134324a6cee'),
                        _buildGalleryImage(
                            'https://images.unsplash.com/photo-1497366754035-f200968a6e72'),
                        _buildGalleryImage(
                            'https://images.unsplash.com/photo-1521791136064-7986c2920216'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Reviews
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Reviews',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Navigate to all reviews
                        },
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  _buildReviewItem(),
                  _buildReviewItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceChip(String service) {
    return Chip(
      label: Text(service),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildDayChip(BuildContext context, String day, bool available) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(day),
        backgroundColor: available
            ? Theme.of(context).primaryColor.withOpacity(0.2)
            : Colors.grey[200],
        labelStyle: TextStyle(
          color: available ? Theme.of(context).primaryColor : Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2, // Add subtle shadow
      ),
    );
  }

  Widget _buildGalleryImage(String url) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildReviewItem() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundImage:
                NetworkImage('https://randomuser.me/api/portraits/women/1.jpg'),
              ),
              const SizedBox(width: 8),
              const Text(
                'Ayesha Khan',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${worker['rating']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Ali did a great job fixing our electrical issues. He was punctual and professional. Highly recommended!',
          ),
          const SizedBox(height: 8),
          Text(
            '2 weeks ago',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }
}