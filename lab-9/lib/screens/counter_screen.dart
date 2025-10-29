import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _saveCounter(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', value);
  }

  void _increment() {
    setState(() {
      _counter++;
    });
    _saveCounter(_counter);
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
    _saveCounter(_counter);
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
    _saveCounter(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 2: Counter Persistence'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Counter Value:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text('$_counter', style: Theme.of(context).textTheme.displayLarge),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _decrement,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 16),
                FloatingActionButton(
                  onPressed: _increment,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _reset, child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}
