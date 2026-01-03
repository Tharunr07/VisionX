import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tripNameController = TextEditingController();
  final _startingCityController = TextEditingController();
  final _destinationCityController = TextEditingController();
  final _budgetController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  final List<Map<String, String>> _suggestions = [
    {'name': 'Paris', 'image': 'assets/images/paris.png'},
    {'name': 'Tokyo', 'image': 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400'},
    {'name': 'Bali', 'image': 'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=400'},
    {'name': 'Rome', 'image': 'https://images.unsplash.com/photo-1555992336-fb0d29498b13?w=400'},
    {'name': 'New York', 'image': 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=400'},
    {'name': 'London', 'image': 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=400'},
  ];

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _continueToItinerary() {
    if (_formKey.currentState!.validate()) {
      // Navigate to itinerary screen with trip data
      Navigator.pushNamed(context, '/build-itinerary', arguments: {
        'tripName': _tripNameController.text,
        'startDate': _startDate,
        'endDate': _endDate,
        'startingCity': _startingCityController.text,
        'destinationCity': _destinationCityController.text,
        'budget': _budgetController.text,
      });
    }
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
          CircleAvatar(
            radius: 16,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a New Trip',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Plan your perfect adventure',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // Trip Details Form
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _tripNameController,
                        decoration: const InputDecoration(
                          labelText: 'Trip Name',
                          prefixIcon: Icon(Icons.trip_origin),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a trip name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, true),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Start Date',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                child: Text(
                                  _startDate != null
                                      ? DateFormat('MMM dd, yyyy').format(_startDate!)
                                      : 'Select date',
                                  style: TextStyle(
                                    color: _startDate != null ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context, false),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'End Date',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                child: Text(
                                  _endDate != null
                                      ? DateFormat('MMM dd, yyyy').format(_endDate!)
                                      : 'Select date',
                                  style: TextStyle(
                                    color: _endDate != null ? Colors.black : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _startingCityController,
                        decoration: const InputDecoration(
                          labelText: 'Starting City (Optional)',
                          prefixIcon: Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _destinationCityController,
                        decoration: const InputDecoration(
                          labelText: 'Destination City (Optional)',
                          prefixIcon: Icon(Icons.flag),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Suggestions Section
              Text(
                'Suggestions for Places to Visit',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          suggestion['image']!.startsWith('assets/')
                              ? Image.asset(
                                  suggestion['image']!,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  suggestion['image']!,
                                  fit: BoxFit.cover,
                                ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                suggestion['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // Action Button
              ElevatedButton(
                onPressed: _continueToItinerary,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Continue'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}