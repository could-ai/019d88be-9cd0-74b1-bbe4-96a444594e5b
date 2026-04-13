import 'package:flutter/material.dart';
import '../theme.dart';

class LoveNotesScreen extends StatefulWidget {
  const LoveNotesScreen({super.key});

  @override
  State<LoveNotesScreen> createState() => _LoveNotesScreenState();
}

class _LoveNotesScreenState extends State<LoveNotesScreen> {
  final List<Map<String, String>> _notes = [
    {
      'date': 'Feb 14, 2024',
      'message': 'Happy Valentine\\'s Day! I love you more than words can say.',
      'author': 'Alex'
    },
    {
      'date': 'Jan 1, 2024',
      'message': 'Here\\'s to another beautiful year together.',
      'author': 'Sam'
    },
    {
      'date': 'Dec 25, 2023',
      'message': 'You are the best gift I could ever ask for.',
      'author': 'Alex'
    },
    {
      'date': 'Nov 10, 2023',
      'message': 'Just thinking about you and smiling.',
      'author': 'Sam'
    },
  ];

  final TextEditingController _noteController = TextEditingController();

  void _addNote() {
    if (_noteController.text.trim().isEmpty) return;

    setState(() {
      _notes.insert(0, {
        'date': 'Just now',
        'message': _noteController.text.trim(),
        'author': 'Me',
      });
    });
    
    _noteController.clear();
    Navigator.pop(context);
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Write a Love Note'),
        content: TextField(
          controller: _noteController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Express your feelings...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: _addNote,
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Love Notes'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note['date']!,
                        style: TextStyle(
                          color: AppTheme.primaryColor.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.favorite,
                        size: 16,
                        color: AppTheme.primaryLight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    note['message']!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '- ${note['author']}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog,
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
