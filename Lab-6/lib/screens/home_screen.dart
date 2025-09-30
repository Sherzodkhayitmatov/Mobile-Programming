import 'package:flutter/material.dart';
import 'favorite_screen.dart';
import 'product_screen.dart';
import 'async_data_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management Tasks'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTaskCard(
            context,
            title: 'Task 1: Favorite Toggle',
            subtitle: 'Refactored StatefulWidget to use Provider',
            icon: Icons.favorite,
            color: Colors.red,
            screen: const FavoriteScreen(),
          ),
          _buildTaskCard(
            context,
            title: 'Task 2: Shopping Cart',
            subtitle: 'Multi-screen app with shared cart state',
            icon: Icons.shopping_cart,
            color: Colors.green,
            screen: const ProductScreen(),
          ),
          _buildTaskCard(
            context,
            title: 'Task 3: Async Data Loading',
            subtitle: 'Fetch data with loading states',
            icon: Icons.cloud_download,
            color: Colors.orange,
            screen: const AsyncDataScreen(),
          ),
          _buildTaskCard(
            context,
            title: 'Task 4: Settings Screen',
            subtitle: 'Toggle notifications and adjust volume',
            icon: Icons.settings,
            color: Colors.purple,
            screen: const SettingsScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget screen,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
      ),
    );
  }
}
