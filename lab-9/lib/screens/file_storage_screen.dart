import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('File saved!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
        setState(() {
          _fileContent = 'No file found';
        });
      }
    } catch (e) {
      setState(() {
        _fileContent = 'Error reading file: $e';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task 9: File Storage'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current File Content:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Text(
                        _fileContent.isEmpty ? 'No content' : _fileContent,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
