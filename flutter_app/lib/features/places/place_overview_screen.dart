import 'package:flutter/material.dart';

class PlaceOverviewScreen extends StatefulWidget {
  final Map<String, dynamic> place;

  const PlaceOverviewScreen({super.key, required this.place});

  @override
  State<PlaceOverviewScreen> createState() => _PlaceOverviewScreenState();
}

class _PlaceOverviewScreenState extends State<PlaceOverviewScreen> {
  bool _isSaved = false;

  List<Map<String, String>> _getHighlightsForPlace(String placeName) {
    switch (placeName.toLowerCase()) {
      case 'paris':
        return [
          {'title': 'Eiffel Tower', 'description': 'Iconic iron lattice tower and symbol of Paris'},
          {'title': 'Louvre Museum', 'description': 'World\'s largest art museum with masterpieces'},
          {'title': 'French Cuisine', 'description': 'Croissants, wine, and gourmet dining experiences'},
        ];
      case 'tokyo':
        return [
          {'title': 'Modern Architecture', 'description': 'Futuristic skyscrapers and cutting-edge design'},
          {'title': 'Traditional Temples', 'description': 'Ancient shrines and cultural heritage sites'},
          {'title': 'Street Food', 'description': 'Vibrant food markets and sushi experiences'},
        ];
      case 'bali':
        return [
          {'title': 'Beautiful Beaches', 'description': 'Pristine sands and turquoise waters'},
          {'title': 'Rice Terraces', 'description': 'Stunning agricultural landscapes'},
          {'title': 'Spa Retreats', 'description': 'Luxurious wellness and relaxation centers'},
        ];
      case 'rome':
        return [
          {'title': 'Ancient Ruins', 'description': 'Colosseum and Roman Forum historical sites'},
          {'title': 'Vatican City', 'description': 'St. Peter\'s Basilica and Sistine Chapel'},
          {'title': 'Italian Cuisine', 'description': 'Pizza, pasta, and gelato delights'},
        ];
      case 'new york':
        return [
          {'title': 'Skyline Views', 'description': 'Iconic Manhattan skyscrapers and bridges'},
          {'title': 'Broadway Shows', 'description': 'World-class theater and entertainment'},
          {'title': 'Diverse Cuisine', 'description': 'Global food scene from every culture'},
        ];
      case 'london':
        return [
          {'title': 'Royal Palaces', 'description': 'Buckingham Palace and royal heritage'},
          {'title': 'Historic Landmarks', 'description': 'Big Ben, Tower Bridge, and Thames River'},
          {'title': 'Pub Culture', 'description': 'Traditional pubs and British ale experiences'},
        ];
      case 'kashmir':
        return [
          {'title': 'Dal Lake', 'description': 'Serene lake with houseboats and gardens'},
          {'title': 'Mountain Views', 'description': 'Himalayan peaks and valley landscapes'},
          {'title': 'Handicrafts', 'description': 'Pashmina shawls and traditional Kashmiri art'},
        ];
      case 'kerala':
        return [
          {'title': 'Backwaters', 'description': 'Canal networks and houseboat cruises'},
          {'title': 'Spice Plantations', 'description': 'Aromatic spice gardens and farms'},
          {'title': 'Ayurvedic Spas', 'description': 'Traditional wellness and healing centers'},
        ];
      case 'rajasthan':
        return [
          {'title': 'Desert Landscapes', 'description': 'Thar Desert dunes and camel safaris'},
          {'title': 'Palace Architecture', 'description': 'Majestic forts and royal heritage'},
          {'title': 'Folk Music', 'description': 'Traditional Rajasthani music and dance'},
        ];
      case 'goa':
        return [
          {'title': 'Beaches', 'description': 'Golden sands and coastal relaxation'},
          {'title': 'Portuguese Heritage', 'description': 'Colonial architecture and churches'},
          {'title': 'Seafood Cuisine', 'description': 'Fresh catch and coastal dining'},
        ];
      case 'agra':
        return [
          {'title': 'Taj Mahal', 'description': 'Marble mausoleum and symbol of love'},
          {'title': 'Agra Fort', 'description': 'Red sandstone fort with Mughal history'},
          {'title': 'Mughal Cuisine', 'description': 'Rich flavors and biryani specialties'},
        ];
      case 'himachal':
        return [
          {'title': 'Hill Stations', 'description': 'Shimla, Manali, and mountain retreats'},
          {'title': 'Adventure Sports', 'description': 'Trekking, paragliding, and skiing'},
          {'title': 'Apple Orchards', 'description': 'Fruit gardens and local produce'},
        ];
      case 'karnataka':
        return [
          {'title': 'Mysore Palace', 'description': 'Opulent royal palace and gardens'},
          {'title': 'Coffee Plantations', 'description': 'Hill estates and fresh brew experiences'},
          {'title': 'Silk Industry', 'description': 'Traditional weaving and silk sarees'},
        ];
      default:
        return [
          {'title': 'Scenic Views', 'description': 'Breathtaking landscapes and natural wonders'},
          {'title': 'Cultural Heritage', 'description': 'Rich history and traditional experiences'},
          {'title': 'Local Cuisine', 'description': 'Authentic flavors and culinary delights'},
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Place Overview'),
        actions: [
          IconButton(
            icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              setState(() {
                _isSaved = !_isSaved;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(_isSaved ? 'Saved to favorites' : 'Removed from favorites')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.place['image']!.startsWith('assets/')
                      ? AssetImage(widget.place['image']!)
                      : NetworkImage(widget.place['image']!),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Place Info
                  Text(
                    widget.place['name']!,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore the beauty and culture of ${widget.place['name']}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.place['name']} offers a unique blend of natural beauty, rich history, and vibrant culture. Whether you\'re seeking adventure, relaxation, or cultural immersion, this destination has something for everyone.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),

                  // Key Highlights
                  Text(
                    'Key Highlights',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._getHighlightsForPlace(widget.place['name']!).map((highlight) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: _buildHighlightCard(highlight['title']!, highlight['description']!),
                    );
                  }),
                ],
              ),
            ),

            // Best Time to Visit
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Best Time to Visit',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.place['bestTimeToVisit'] ?? 'Varies by season',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

            // Budget per Day
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        color: Theme.of(context).colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Budget per Day',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.place['budgetPerDay'] ?? '₹4,150-12,450',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  // Add to trip
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to trip')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: BorderSide(color: Theme.of(context).colorScheme.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Add to Trip',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // View itinerary
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Viewing itinerary')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('View Itinerary'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightCard(String title, String description) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    ),
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