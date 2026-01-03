import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GlobeTrotter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigate to edit profile
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Header
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/logo.png'), // Placeholder
            ),
            const SizedBox(height: 16),
            Text(
              'John Doe', // Placeholder
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'john.doe@example.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Explorer | Food Lover | Budget Traveler',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Profile Summary
            _buildSummaryCard(
              context,
              icon: Icons.flight_takeoff,
              title: 'Preferred Travel Style',
              subtitle: 'Adventure',
            ),
            const SizedBox(height: 12),
            _buildSummaryCard(
              context,
              icon: Icons.location_on,
              title: 'Home Location',
              subtitle: 'New York, USA',
            ),
            const SizedBox(height: 12),
            _buildSummaryCard(
              context,
              icon: Icons.language,
              title: 'Language / Region',
              subtitle: 'English (US)',
            ),
            const SizedBox(height: 32),

            // Personal Information
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Personal Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              context,
              icon: Icons.phone,
              title: 'Phone Number',
              subtitle: '+1 (555) 123-4567',
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              context,
              icon: Icons.email,
              title: 'Email Address',
              subtitle: 'john.doe@example.com',
            ),
            const SizedBox(height: 12),
            _buildInfoCard(
              context,
              icon: Icons.cake,
              title: 'Date of Birth',
              subtitle: 'January 1, 1990',
            ),
            const SizedBox(height: 32),

            // Account Settings
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account Settings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildActionTile(
              context,
              icon: Icons.edit,
              title: 'Edit Profile',
              onTap: () {
                // Navigate to edit profile
              },
            ),
            const Divider(),
            _buildActionTile(
              context,
              icon: Icons.settings,
              title: 'Preferences',
              onTap: () {
                // Navigate to preferences
              },
            ),
            const Divider(),
            _buildActionTile(
              context,
              icon: Icons.notifications,
              title: 'Notifications',
              onTap: () {
                // Navigate to notifications
              },
            ),
            const Divider(),
            _buildActionTile(
              context,
              icon: Icons.security,
              title: 'Privacy & Security',
              onTap: () {
                // Navigate to privacy
              },
            ),
            const Divider(),
            _buildActionTile(
              context,
              icon: Icons.help,
              title: 'Help & Support',
              onTap: () {
                // Navigate to help
              },
            ),
            const Divider(),
            _buildActionTile(
              context,
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSummaryCard(BuildContext context, {required IconData icon, required String title, required String subtitle}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, {required IconData icon, required String title, required String subtitle}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}