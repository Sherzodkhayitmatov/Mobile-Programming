import 'package:flutter/material.dart';
import 'username_screen.dart';
import 'counter_screen.dart';
import 'theme_screen.dart';
import 'notes_list_screen.dart';
import 'file_storage_screen.dart';
import 'hybrid_storage_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persistence Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(context, 'Part A: Shared Preferences', [
            _buildButton(
              context,
              'Task 1: Username Save',
              const UsernameScreen(),
            ),
            _buildButton(
              context,
              'Task 2: Counter Persistence',
              const CounterScreen(),
            ),
            _buildButton(
              context,
              'Task 3: Dark Mode Toggle',
              const ThemeScreen(),
            ),
          ]),
          const SizedBox(height: 16),
          _buildCard(context, 'Part B & C: SQLite CRUD', [
            _buildButton(
              context,
              'Tasks 4-8: Notes App',
              const NotesListScreen(),
            ),
          ]),
          const SizedBox(height: 16),
          _buildCard(context, 'Part D: Advanced Persistence', [
            _buildButton(
              context,
              'Task 9: File Storage',
              const FileStorageScreen(),
            ),
            _buildButton(
              context,
              'Task 10: Hybrid Storage',
              const HybridStorageScreen(),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
          child: Text(label),
        ),
      ),
    );
  }
}
