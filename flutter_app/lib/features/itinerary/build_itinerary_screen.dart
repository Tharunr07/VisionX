import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildItineraryScreen extends StatefulWidget {
  const BuildItineraryScreen({super.key});

  @override
  State<BuildItineraryScreen> createState() => _BuildItineraryScreenState();
}

class _BuildItineraryScreenState extends State<BuildItineraryScreen> {
  final List<ItineraryDay> _days = [
    ItineraryDay(dayNumber: 1, date: DateTime.now(), activities: '', budget: ''),
    ItineraryDay(dayNumber: 2, date: DateTime.now().add(const Duration(days: 1)), activities: '', budget: ''),
    ItineraryDay(dayNumber: 3, date: DateTime.now().add(const Duration(days: 2)), activities: '', budget: ''),
  ];

  @override
  void initState() {
    super.initState();
    // Get trip data from arguments if available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (arguments != null) {
        // Update dates based on trip start date
        final startDate = arguments['startDate'] as DateTime?;
        if (startDate != null) {
          setState(() {
            for (int i = 0; i < _days.length; i++) {
              _days[i] = _days[i].copyWith(date: startDate.add(Duration(days: i)));
            }
          });
        }
      }
    });
  }

  void _addNewDay() {
    final lastDay = _days.last;
    final newDay = ItineraryDay(
      dayNumber: lastDay.dayNumber + 1,
      date: lastDay.date.add(const Duration(days: 1)),
      activities: '',
      budget: '',
    );
    setState(() {
      _days.add(newDay);
    });
  }

  void _updateDay(int index, ItineraryDay updatedDay) {
    setState(() {
      _days[index] = updatedDay;
    });
  }

  void _saveItinerary() {
    // Save itinerary logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Itinerary saved successfully!')),
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
            icon: const Icon(Icons.save, color: Colors.black),
            onPressed: _saveItinerary,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _days.length + 1, // +1 for the add button
              itemBuilder: (context, index) {
                if (index < _days.length) {
                  return _buildDaySection(_days[index], index);
                } else {
                  return _buildAddDayButton();
                }
              },
            ),
          ),
          // Bottom action area
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // View itinerary logic
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: const Text('View Itinerary'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveItinerary,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Save Itinerary'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySection(ItineraryDay day, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'Day ${day.dayNumber}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  DateFormat('MMM dd, yyyy').format(day.date),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: day.activities,
              decoration: const InputDecoration(
                labelText: 'Activities, locations, or notes',
                hintText: 'e.g., Visit Eiffel Tower, lunch at local cafe, evening walk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              onChanged: (value) {
                _updateDay(index, day.copyWith(activities: value));
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: day.budget,
              decoration: const InputDecoration(
                labelText: 'Budget for this day',
                hintText: 'e.g., \$150',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                _updateDay(index, day.copyWith(budget: value));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddDayButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: OutlinedButton.icon(
        onPressed: _addNewDay,
        icon: const Icon(Icons.add),
        label: const Text('Add Another Day'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class ItineraryDay {
  final int dayNumber;
  final DateTime date;
  final String activities;
  final String budget;

  ItineraryDay({
    required this.dayNumber,
    required this.date,
    required this.activities,
    required this.budget,
  });

  ItineraryDay copyWith({
    int? dayNumber,
    DateTime? date,
    String? activities,
    String? budget,
  }) {
    return ItineraryDay(
      dayNumber: dayNumber ?? this.dayNumber,
      date: date ?? this.date,
      activities: activities ?? this.activities,
      budget: budget ?? this.budget,
    );
  }
}