import 'package:flutter/material.dart';
import 'package:cotravel/features/trip/trip_listing_screen.dart';
import 'package:cotravel/features/profile/profile_screen.dart';
import 'package:cotravel/features/activities/activities_screen.dart';
import 'package:cotravel/features/activities/saved_activities_screen.dart';
import 'package:cotravel/features/calendar/trip_calendar_screen.dart';
import 'package:cotravel/features/places/place_overview_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? _selectedGroup;

  final List<String> _groupOptions = ['Family', 'Solo', 'Couple', 'Friends'];

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


  Map<String, dynamic> _getPlaceData(String name, String imageUrl) {
    // Base data
    final data = {
      'name': name,
      'image': imageUrl,
    };

    // Add specific data based on place name
    switch (name.toLowerCase()) {
      case 'paris':
        data.addAll({
          'bestTimeToVisit': 'April to June, September to October',
          'budgetPerDay': '₹8,300-16,600',
        });
        break;
      case 'tokyo':
        data.addAll({
          'bestTimeToVisit': 'March to May, September to November',
          'budgetPerDay': '₹6,640-12,450',
        });
        break;
      case 'bali':
        data.addAll({
          'bestTimeToVisit': 'April to September',
          'budgetPerDay': '₹4,150-9,960',
        });
        break;
      case 'rome':
        data.addAll({
          'bestTimeToVisit': 'April to June, September to October',
          'budgetPerDay': '₹7,470-14,940',
        });
        break;
      case 'new york':
        data.addAll({
          'bestTimeToVisit': 'April to June, September to November',
          'budgetPerDay': '₹12,450-24,900',
        });
        break;
      case 'london':
        data.addAll({
          'bestTimeToVisit': 'March to May, September to November',
          'budgetPerDay': '₹9,960-20,750',
        });
        break;
      case 'kashmir':
        data.addAll({
          'bestTimeToVisit': 'April to June, September to October',
          'budgetPerDay': '₹4,980-9,960',
        });
        break;
      case 'kerala':
        data.addAll({
          'bestTimeToVisit': 'November to March',
          'budgetPerDay': '₹4,150-8,300',
        });
        break;
      case 'rajasthan':
        data.addAll({
          'bestTimeToVisit': 'October to March',
          'budgetPerDay': '₹3,320-7,470',
        });
        break;
      case 'goa':
        data.addAll({
          'bestTimeToVisit': 'November to May',
          'budgetPerDay': '₹4,150-8,300',
        });
        break;
      case 'agra':
        data.addAll({
          'bestTimeToVisit': 'October to March',
          'budgetPerDay': '₹3,320-6,640',
        });
        break;
      case 'himachal':
        data.addAll({
          'bestTimeToVisit': 'March to June, September to November',
          'budgetPerDay': '₹4,980-9,960',
        });
        break;
      case 'karnataka':
        data.addAll({
          'bestTimeToVisit': 'October to May',
          'budgetPerDay': '₹4,150-8,300',
        });
        break;
      default:
        data.addAll({
          'bestTimeToVisit': 'Varies by season',
          'budgetPerDay': '₹4,150-12,450',
        });
    }

    return data;
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              title: const Text('Activities'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ActivitiesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Saved Activities'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SavedActivitiesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Trip Calendar'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TripCalendarScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Trip Listing'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TripListingScreen()),
                );
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

  Widget _buildDestinationCard(String name, String imageUrl) {
    // Get additional place data
    final placeData = _getPlaceData(name, imageUrl);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlaceOverviewScreen(
              place: placeData,
            ),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: imageUrl.startsWith('assets/') ? AssetImage(imageUrl) : NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard(String name, String date, String imageUrl) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.6),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
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
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 28,
              height: 28,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 8),
            Text(
              'CoTravel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => _showAccountMenu(context),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore the World',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Discover your next adventure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Search & Filter Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search destinations, trips, or activities...',
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
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.group, color: Colors.white, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              _selectedGroup ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
                          ],
                        ),
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
                      icon: const Icon(Icons.sort, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Top Regional Selections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Top Destinations',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildDestinationCard('Paris', 'assets/images/paris.png'),
                  _buildDestinationCard('Europe', 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400'),
                  _buildDestinationCard('Asia', 'https://images.unsplash.com/photo-1508804185872-d7badad00f7d?w=400'),
                  _buildDestinationCard('Bali', 'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=400'),
                  _buildDestinationCard('Japan', 'https://images.unsplash.com/photo-1490806843957-31f4c9a91c65?w=400'),
                ],
              ),
            ),


            const SizedBox(height: 24),

            // Regional Places in India
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Explore India',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildDestinationCard('Kashmir', 'assets/images/kashmir.png'),
                  _buildDestinationCard('Kerala', 'https://images.unsplash.com/photo-1602216056096-3b40cc0c9944?w=400'),
                  _buildDestinationCard('Rajasthan', 'assets/images/rajasthanpalace.png'),
                  _buildDestinationCard('Goa', 'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=400'),
                  _buildDestinationCard('Agra', 'assets/images/tajmahal.png'),
                  _buildDestinationCard('Himachal', 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400'),
                  _buildDestinationCard('Karnataka', 'assets/images/mysurupalace.png'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Previous Trips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Previous Trips',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildTripCard('Tokyo Adventure', 'Dec 2023', 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400'),
                  _buildTripCard('Bali Paradise', 'Aug 2023', 'https://images.unsplash.com/photo-1537953773345-d172ccf13cf1?w=400'),
                  _buildTripCard('European Tour', 'Jun 2023', 'https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=400'),
                ],
              ),
            ),

            const SizedBox(height: 80), // Space for FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/create-trip');
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Plan a Trip'),
        elevation: 6,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}