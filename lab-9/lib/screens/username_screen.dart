import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final _controller = TextEditingController();
  String _savedUsername = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedUsername = prefs.getString('username') ?? '';
      _controller.text = _savedUsername;
    });
  }

  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _controller.text);
    setState(() {
      _savedUsername = _controller.text;
    });
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Username saved!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1: Username Save'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saved Username: $_savedUsername',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveUsername,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
