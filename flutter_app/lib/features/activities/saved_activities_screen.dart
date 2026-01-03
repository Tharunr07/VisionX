import 'package:flutter/material.dart';
import 'package:cotravel/features/activities/activity_details_screen.dart';
import 'package:cotravel/features/activities/activities_screen.dart';

class SavedActivitiesScreen extends StatefulWidget {
  const SavedActivitiesScreen({super.key});

  @override
  State<SavedActivitiesScreen> createState() => _SavedActivitiesScreenState();
}

class _SavedActivitiesScreenState extends State<SavedActivitiesScreen> {
  // Simulated saved activities - in real app, this would come from storage
  List<Map<String, dynamic>> _savedActivities = [
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
      'image': 'https://images.unsplash.com/photo-1541961017774-22349e4a1262?w=400',
    },
  ];

  void _removeActivity(int index) {
    setState(() {
      _savedActivities.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Removed from saved activities')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Saved Activities'),
        actions: [
          if (_savedActivities.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () {
                setState(() {
                  _savedActivities.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Cleared all saved activities')),
                );
              },
            ),
        ],
      ),
      body: _savedActivities.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _savedActivities.length,
              itemBuilder: (context, index) {
                final activity = _savedActivities[index];
                return Dismissible(
                  key: Key(activity['name']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20.0),
                    color: Colors.red,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    _removeActivity(index);
                  },
                  child: _buildActivityCard(context, activity),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bookmark_border,
              size: 80,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No saved activities yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Save activities to plan your next adventure',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ActivitiesScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Explore Activities'),
            ),
          ],
        ),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ActivityDetailsScreen(activity: activity),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: activity['image'].startsWith('assets/')
                    ? Image.asset(
                        activity['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        activity['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity['name'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
      ),
    );
  }
}