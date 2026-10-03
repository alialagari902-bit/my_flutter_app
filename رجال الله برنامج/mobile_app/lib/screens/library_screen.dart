import 'package:flutter/material.dart';
import '../db_helper.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Map<String, dynamic>> books = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final localBooks = await DBHelper.getBooks();
    setState(() {
      books = localBooks;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : books.isEmpty
              ? const Center(child: Text('لا توجد كتب أو ملازم حالياً.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ExpansionTile(
                        leading: _getIconForCategory(book['category']),
                        title: Text(book['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(book['author'] ?? ''),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              book['content'] ?? 'لا يوجد نص',
                              style: const TextStyle(fontSize: 16, height: 1.5),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }

  Widget _getIconForCategory(String? category) {
    switch (category) {
      case 'ملازم':
        return const Icon(Icons.book, color: Colors.brown);
      case 'حكم':
        return const Icon(Icons.lightbulb, color: Colors.amber);
      case 'أدعية':
        return const Icon(Icons.mosque, color: Colors.green);
      default:
        return const Icon(Icons.auto_stories, color: Colors.blueGrey);
    }
  }
}
