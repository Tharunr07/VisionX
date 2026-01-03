import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cotravel/features/activities/activity_details_screen.dart';

class TripCalendarScreen extends StatefulWidget {
  const TripCalendarScreen({super.key});

  @override
  State<TripCalendarScreen> createState() => _TripCalendarScreenState();
}

class _TripCalendarScreenState extends State<TripCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Simulated events - in real app, this would come from data
  late final Map<DateTime, List<Map<String, dynamic>>> _events;

  @override
  void initState() {
    super.initState();
    _events = _generateEventsFromTrips();
  }

  Map<DateTime, List<Map<String, dynamic>>> _generateEventsFromTrips() {
    final Map<DateTime, List<Map<String, dynamic>>> events = {};

    // Ongoing trips
    final ongoingTrips = [
      {
        'name': 'Tokyo Adventure',
        'destination': 'Tokyo, Japan',
        'startDate': DateTime.now().subtract(const Duration(days: 2)),
        'endDate': DateTime.now().add(const Duration(days: 5)),
        'status': 'ongoing',
      },
    ];

    // Upcoming trips
    final upcomingTrips = [
      {
        'name': 'Paris Romance',
        'destination': 'Paris, France',
        'startDate': DateTime.now().add(const Duration(days: 30)),
        'endDate': DateTime.now().add(const Duration(days: 37)),
        'status': 'upcoming',
      },
      {
        'name': 'Bali Paradise',
        'destination': 'Bali, Indonesia',
        'startDate': DateTime.now().add(const Duration(days: 60)),
        'endDate': DateTime.now().add(const Duration(days: 67)),
        'status': 'upcoming',
      },
    ];

    // Add trip events for each day in the range
    for (final trip in [...ongoingTrips, ...upcomingTrips]) {
      final start = trip['startDate'] as DateTime;
      final end = trip['endDate'] as DateTime;
      for (int i = 0; i <= end.difference(start).inDays; i++) {
        final date = DateTime(start.year, start.month, start.day).add(Duration(days: i));
        final event = {
          'type': 'trip',
          'name': trip['name'],
          'location': trip['destination'],
          'time': 'All day',
          'status': trip['status'],
        };
        if (events[date] == null) {
          events[date] = [];
        }
        // Avoid duplicates
        if (!events[date]!.any((e) => e['name'] == event['name'])) {
          events[date]!.add(event);
        }
      }
    }

    // Add some sample activities
    final activityDate1 = DateTime.now().add(const Duration(days: 3));
    events[activityDate1] ??= [];
    events[activityDate1]!.addAll([
      {
        'type': 'activity',
        'name': 'Mountain Hiking',
        'location': 'Swiss Alps',
        'time': '9:00 AM',
      },
      {
        'type': 'activity',
        'name': 'Cultural Museum Tour',
        'location': 'Paris',
        'time': '2:00 PM',
      },
    ]);

    return events;
  }

  List<Map<String, dynamic>> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Trip Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.view_list),
            onPressed: () {
              // Toggle view - for now, just show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('View toggle - Month view')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const Divider(),
          Expanded(
            child: _buildScheduledItems(),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledItems() {
    final events = _selectedDay != null ? _getEventsForDay(_selectedDay!) : [];

    if (events.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_note,
                size: 64,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: 16),
              Text(
                'No activities planned for this day',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.only(bottom: 12.0),
          child: ListTile(
            leading: Icon(
              event['type'] == 'trip' ? Icons.flight : Icons.explore,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              event['name'],
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['location'],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event['time'],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigate to trip or activity details
              if (event['type'] == 'activity') {
                // For demo, use a sample activity
                final sampleActivity = {
                  'name': event['name'],
                  'location': event['location'],
                  'tag': 'Adventure',
                  'rating': 4.8,
                  'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
                };
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ActivityDetailsScreen(activity: sampleActivity),
                  ),
                );
              } else {
                // For trips, show snackbar for now
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigate to ${event['name']} details')),
                );
              }
            },
          ),
        );
      },
    );
  }
}