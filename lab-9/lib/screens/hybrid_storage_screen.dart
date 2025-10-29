import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../database/database_helper.dart';

class HybridStorageScreen extends StatefulWidget {
  const HybridStorageScreen({super.key});

  @override
  State<HybridStorageScreen> createState() => _HybridStorageScreenState();
}

class _HybridStorageScreenState extends State<HybridStorageScreen> {
  double _fontSize = 16.0;
  int _notesCount = 0;
  final _dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadNotesCount();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('font_size') ?? 16.0;
    });
  }

  Future<void> _saveFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size', size);
    setState(() {
      _fontSize = size;
    });
  }

  Future<void> _loadNotesCount() async {
    final notes = await _dbHelper.getAllNotes();
    setState(() {
      _notesCount = notes.length;
    });
  }

  Future<void> _addSampleNote() async {
    final note = {
      'title': 'Sample Note ${DateTime.now().millisecondsSinceEpoch}',
      'content': 'This is a sample note for hybrid storage demo',
    };
    await _dbHelper.insertNote(note);
    _loadNotesCount();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note added to SQLite!')));
    }
  }

  Future<void> _clearAllNotes() async {
    final notes = await _dbHelper.getAllNotes();
    for (var note in notes) {
      await _dbHelper.deleteNote(note['id'] as int);
    }
    _loadNotesCount();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All notes cleared!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 10: Hybrid Storage'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SharedPreferences Settings',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Font Size: ${_fontSize.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    value: _fontSize,
                    min: 12.0,
                    max: 32.0,
                    divisions: 20,
                    label: _fontSize.toStringAsFixed(0),
                    onChanged: _saveFontSize,
                  ),
                  const SizedBox(height: 16),
                  Text('Preview Text', style: TextStyle(fontSize: _fontSize)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SQLite Data',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total Notes: $_notesCount',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _addSampleNote,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Note'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _clearAllNotes,
                          icon: const Icon(Icons.delete_sweep),
                          label: const Text('Clear All'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hybrid Storage Demo',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This app demonstrates both SharedPreferences (for font size) and SQLite (for notes count) working together.',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
