import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('dark_mode') ?? false;
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatefulWidget {
  final bool isDark;
  const MyApp({super.key, required this.isDark});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext ctx) =>
      ctx.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme(bool isDark) async {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dark_mode', isDark);
  }

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'Persistence Demo',
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persistence Demo'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            ctx,
            'Part A: Shared Preferences',
            [
              _buildButton(
                  ctx, 'Task 1: Username Save', const UsernameScreen()),
              _buildButton(
                  ctx, 'Task 2: Counter Persistence', const CounterScreen()),
              _buildButton(
                  ctx, 'Task 3: Dark Mode Toggle', const ThemeScreen()),
            ],
          ),
          const SizedBox(height: 16),
          _buildCard(
            ctx,
            'Part B & C: SQLite CRUD',
            [
              _buildButton(
                  ctx, 'Tasks 4-8: Notes App', const NotesListScreen()),
            ],
          ),
          const SizedBox(height: 16),
          _buildCard(
            ctx,
            'Part D: Advanced Persistence',
            [
              _buildButton(
                  ctx, 'Task 9: File Storage', const FileStorageScreen()),
              _buildButton(
                  ctx, 'Task 10: Hybrid Storage', const HybridStorageScreen()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext ctx, String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext ctx, String label, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            ctx,
            MaterialPageRoute(builder: (_) => screen),
          ),
          child: Text(label),
        ),
      ),
    );
  }
}

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
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Username saved!')),
      );
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 1: Username Save'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saved Username: $_savedUsername',
                style: Theme.of(ctx).textTheme.titleLarge),
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
    setState(() => _counter++);
    _saveCounter(_counter);
  }

  void _decrement() {
    setState(() => _counter--);
    _saveCounter(_counter);
  }

  void _reset() {
    setState(() => _counter = 0);
    _saveCounter(_counter);
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 2: Counter Persistence'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter Value:', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 16),
            Text('$_counter', style: Theme.of(ctx).textTheme.displayLarge),
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

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('dark_mode') ?? false;
    });
  }

  void _toggleTheme(bool value) {
    setState(() => _isDarkMode = value);
    MyApp.of(context as BuildContext)?.toggleTheme(value);
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 3: Dark Mode Toggle'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Theme Settings', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Dark Mode'),
              subtitle: Text(_isDarkMode ? 'Enabled' : 'Disabled'),
              value: _isDarkMode,
              onChanged: _toggleTheme,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Preview', style: Theme.of(ctx).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(
                      'This is how the app looks in ${_isDarkMode ? 'dark' : 'light'} mode.',
                      style: Theme.of(ctx).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertNote(Map<String, dynamic> note) async {
    final db = await database;
    return await db.insert('notes', note);
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await database;
    return await db.query('notes', orderBy: 'id DESC');
  }

  Future<int> updateNote(int id, Map<String, dynamic> note) async {
    final db = await database;
    return await db.update('notes', note, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}

class Note {
  final int? id;
  final String title;
  final String content;

  Note({this.id, required this.title, required this.content});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
    );
  }
}

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
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Note added!')),
      );
    }
  }

  Future<void> _deleteNote(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _dbHelper.deleteNote(id);
      _loadNotes();
      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('Note deleted!')),
        );
      }
    }
  }

  Future<void> _navigateToDetail({Note? note}) async {
    final result = await Navigator.push(
      context as BuildContext,
      MaterialPageRoute(builder: (_) => NoteDetailScreen(note: note)),
    );
    if (result == true) _loadNotes();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks 4-8: Notes App'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_outlined,
                          size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text('No notes yet',
                          style: Theme.of(ctx).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text('Tap + to add a note',
                          style: Theme.of(ctx).textTheme.bodyMedium),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: _notes.length,
                  itemBuilder: (_, index) {
                    final note = _notes[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: ListTile(
                        title: Text(note.title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(note.content,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
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

class NoteDetailScreen extends StatefulWidget {
  final Note? note;
  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _dbHelper = DatabaseHelper.instance;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _isEditing = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _saveNote() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final note = Note(
      id: widget.note?.id,
      title: _titleController.text,
      content: _contentController.text,
    );

    if (_isEditing) {
      await _dbHelper.updateNote(note.id!, note.toMap());
    } else {
      await _dbHelper.insertNote(note.toMap());
    }

    if (mounted) Navigator.pop(context as BuildContext, true);
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Note' : 'New Note'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
        actions: [
          IconButton(icon: const Icon(Icons.check), onPressed: _saveNote),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileStorageScreen extends StatefulWidget {
  const FileStorageScreen({super.key});

  @override
  State<FileStorageScreen> createState() => _FileStorageScreenState();
}

class _FileStorageScreenState extends State<FileStorageScreen> {
  final _controller = TextEditingController();
  String _fileContent = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _readFile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/user_data.txt');
  }

  Future<void> _writeFile() async {
    setState(() => _isLoading = true);
    try {
      final file = await _getFile();
      await file.writeAsString(_controller.text);
      await _readFile();
      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          const SnackBar(content: Text('File saved!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _readFile() async {
    setState(() => _isLoading = true);
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final content = await file.readAsString();
        setState(() {
          _fileContent = content;
          _controller.text = content;
        });
      } else {
        setState(() => _fileContent = 'No file found');
      }
    } catch (e) {
      setState(() => _fileContent = 'Error reading file: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 9: File Storage'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current File Content:',
                style: Theme.of(ctx).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Text(_fileContent.isEmpty ? 'No content' : _fileContent,
                        style: Theme.of(ctx).textTheme.bodyMedium),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Enter text to save',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _writeFile,
                    icon: const Icon(Icons.save),
                    label: const Text('Write File'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _readFile,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Read File'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
    setState(() => _fontSize = prefs.getDouble('font_size') ?? 16.0);
  }

  Future<void> _saveFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('font_size', size);
    setState(() => _fontSize = size);
  }

  Future<void> _loadNotesCount() async {
    final notes = await _dbHelper.getAllNotes();
    setState(() => _notesCount = notes.length);
  }

  Future<void> _addSampleNote() async {
    final note = {
      'title': 'Sample Note ${DateTime.now().millisecondsSinceEpoch}',
      'content': 'This is a sample note for hybrid storage demo',
    };
    await _dbHelper.insertNote(note);
    _loadNotesCount();
    if (mounted) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('Note added to SQLite!')),
      );
    }
  }

  Future<void> _clearAllNotes() async {
    final notes = await _dbHelper.getAllNotes();
    for (var note in notes) {
      await _dbHelper.deleteNote(note['id'] as int);
    }
    _loadNotesCount();
    if (mounted) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        const SnackBar(content: Text('All notes cleared!')),
      );
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 10: Hybrid Storage'),
        backgroundColor: Theme.of(ctx).colorScheme.inversePrimary,
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
                  Text('SharedPreferences Settings',
                      style: Theme.of(ctx).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Text('Font Size: ${_fontSize.toStringAsFixed(0)}',
                      style: Theme.of(ctx).textTheme.titleMedium),
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
                  Text('SQLite Data',
                      style: Theme.of(ctx).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  Text('Total Notes: $_notesCount',
                      style: Theme.of(ctx).textTheme.titleMedium),
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
        ],
      ),
    );
  }
}
