import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripListingScreen extends StatefulWidget {
  const TripListingScreen({super.key});

  @override
  State<TripListingScreen> createState() => _TripListingScreenState();
}

class _TripListingScreenState extends State<TripListingScreen> {
  String? _selectedGroup;

  final List<String> _groupOptions = ['Family', 'Solo', 'Couple', 'Friends'];

  // Mock trip data
  final List<Map<String, dynamic>> _ongoingTrips = [
    {
      'name': 'Tokyo Adventure',
      'description': 'Exploring the vibrant city of Tokyo',
      'destination': 'Tokyo, Japan',
      'startDate': DateTime.now().subtract(const Duration(days: 2)),
      'endDate': DateTime.now().add(const Duration(days: 5)),
      'status': 'ongoing',
    },
  ];

  final List<Map<String, dynamic>> _upcomingTrips = [
    {
      'name': 'Paris Romance',
      'description': 'A romantic getaway to the City of Light',
      'destination': 'Paris, France',
      'startDate': DateTime.now().add(const Duration(days: 30)),
      'endDate': DateTime.now().add(const Duration(days: 37)),
      'status': 'upcoming',
    },
    {
      'name': 'Bali Paradise',
      'description': 'Relaxing on the beautiful beaches of Bali',
      'destination': 'Bali, Indonesia',
      'startDate': DateTime.now().add(const Duration(days: 60)),
      'endDate': DateTime.now().add(const Duration(days: 67)),
      'status': 'upcoming',
    },
  ];

  final List<Map<String, dynamic>> _completedTrips = [
    {
      'name': 'European Tour',
      'description': 'A comprehensive tour of major European cities',
      'destination': 'Multiple Cities, Europe',
      'startDate': DateTime.now().subtract(const Duration(days: 120)),
      'endDate': DateTime.now().subtract(const Duration(days: 100)),
      'status': 'completed',
    },
    {
      'name': 'Mountain Hiking',
      'description': 'Adventurous hiking in the Swiss Alps',
      'destination': 'Swiss Alps, Switzerland',
      'startDate': DateTime.now().subtract(const Duration(days: 200)),
      'endDate': DateTime.now().subtract(const Duration(days: 190)),
      'status': 'completed',
    },
  ];

  IconData _getGroupIcon(String group) {
    switch (group) {
      case 'Family':
        return Icons.family_restroom;
      case 'Solo':
        return Icons.person;
      case 'Couple':
        return Icons.favorite;
      case 'Friends':
        return Icons.people;
      default:
        return Icons.group;
    }
  }

  void _showAccountMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Trip Listing'),
              onTap: () {
                Navigator.pop(context);
                // Already on trip listing
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              'CoTravel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () => _showAccountMenu(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Controls
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search trips...',
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
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      setState(() {
                        _selectedGroup = value;
                      });
                    },
                    itemBuilder: (context) => _groupOptions.map((option) {
                      return PopupMenuItem<String>(
                        value: option,
                        child: Row(
                          children: [
                            Icon(
                              _getGroupIcon(option),
                              color: Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(option),
                            if (_selectedGroup == option) ...[
                              const SizedBox(width: 8),
                              Icon(
                                Icons.check,
                                color: Theme.of(context).colorScheme.primary,
                                size: 16,
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.group, color: Colors.white, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sort, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          // Trip Sections
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildTripSection('Ongoing', _ongoingTrips, Colors.blue[50]!),
                const SizedBox(height: 24),
                _buildTripSection('Upcoming', _upcomingTrips, Colors.white),
                const SizedBox(height: 24),
                _buildTripSection('Completed', _completedTrips, Colors.grey[50]!),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripSection(String title, List<Map<String, dynamic>> trips, Color backgroundColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: title == 'Ongoing' ? Theme.of(context).colorScheme.primary : Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        ...trips.map((trip) => _buildTripCard(trip, backgroundColor)),
      ],
    );
  }

  Widget _buildTripCard(Map<String, dynamic> trip, Color backgroundColor) {
    final isOngoing = trip['status'] == 'ongoing';
    final isCompleted = trip['status'] == 'completed';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: isOngoing ? 4 : 2,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isOngoing
            ? BorderSide(color: Theme.of(context).colorScheme.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          // Navigate to trip details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      trip['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isCompleted ? Colors.grey[700] : Colors.black,
                      ),
                    ),
                  ),
                  if (isOngoing)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                trip['description'],
                style: TextStyle(
                  color: isCompleted ? Colors.grey[600] : Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: isCompleted ? Colors.grey[500] : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      trip['destination'],
                      style: TextStyle(
                        color: isCompleted ? Colors.grey[600] : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: isCompleted ? Colors.grey[500] : Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${DateFormat('MMM dd').format(trip['startDate'])} - ${DateFormat('MMM dd, yyyy').format(trip['endDate'])}',
                    style: TextStyle(
                      color: isCompleted ? Colors.grey[600] : Colors.black87,
                      fontSize: 14,
                    ),
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