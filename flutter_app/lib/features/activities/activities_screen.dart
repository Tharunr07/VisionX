import 'package:flutter/material.dart';
import 'package:cotravel/features/activities/activity_details_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Adventure', 'Culture', 'Food', 'Nature', 'Relaxation'];

  final List<Map<String, dynamic>> _activities = [
    {
      'name': 'Mountain Hiking',
      'location': 'Swiss Alps, Switzerland',
      'tag': 'Adventure',
      'rating': 4.8,
      'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
    },
    {
      'name': 'Cultural Museum Tour',
      'location': 'Paris, France',
      'tag': 'Culture',
      'rating': 4.6,
      'image': 'assets/images/paris.png',
    },
    {
      'name': 'Street Food Experience',
      'location': 'Bangkok, Thailand',
      'tag': 'Food',
      'rating': 4.9,
      'image': 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400',
    },
    {
      'name': 'Beach Relaxation',
      'location': 'Bali, Indonesia',
      'tag': 'Relaxation',
      'rating': 4.7,
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
    },
    {
      'name': 'Forest Trekking',
      'location': 'Amazon Rainforest, Brazil',
      'tag': 'Nature',
      'rating': 4.5,
      'image': 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400',
    },
  ];

  List<Map<String, dynamic>> get _filteredActivities {
    if (_selectedFilter == 'All') return _activities;
    return _activities.where((activity) => activity['tag'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Activities'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Open search or filter
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search activities or experiences...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _filters.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = selected ? filter : 'All';
                            });
                          },
                          backgroundColor: Colors.grey[100],
                          selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          checkmarkColor: Theme.of(context).colorScheme.primary,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Activities List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _filteredActivities.length,
              itemBuilder: (context, index) {
                final activity = _filteredActivities[index];
                return _buildActivityCard(context, activity);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Map<String, dynamic> activity) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          // Navigate to Activity Details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ActivityDetailsScreen(activity: activity),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: activity['image'].startsWith('assets/')
                  ? Image.asset(
                      activity['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      activity['image'],
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['name'],
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity['location'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          activity['tag'],
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            activity['rating'].toString(),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}