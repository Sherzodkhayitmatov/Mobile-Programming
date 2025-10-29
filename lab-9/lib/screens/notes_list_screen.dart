import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/note.dart';
import 'note_detail_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final _dbHelper = DatabaseHelper.instance;
  List<Note> _notes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    setState(() => _isLoading = true);
    final notesData = await _dbHelper.getAllNotes();
    setState(() {
      _notes = notesData.map((data) => Note.fromMap(data)).toList();
      _isLoading = false;
    });
  }

  Future<void> _addDummyNote() async {
    final note = Note(
      title: 'Note ${DateTime.now().millisecondsSinceEpoch}',
      content: 'This is a dummy note created at ${DateTime.now()}',
    );
    await _dbHelper.insertNote(note.toMap());
    _loadNotes();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Note added!')));
    }
  }

  Future<void> _deleteNote(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _dbHelper.deleteNote(id);
      _loadNotes();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Note deleted!')));
      }
    }
  }

  Future<void> _navigateToDetail({Note? note}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
    );

    if (result == true) {
      _loadNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks 4-8: Notes App'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.note_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No notes yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add a note',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _deleteNote(note.id!),
                    ),
                    onTap: () => _navigateToDetail(note: note),
                  ),
                );
              },
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add_dummy',
            onPressed: _addDummyNote,
            child: const Icon(Icons.casino),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'add_note',
            onPressed: () => _navigateToDetail(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
