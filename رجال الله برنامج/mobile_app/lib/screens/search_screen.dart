import 'package:flutter/material.dart';
import '../db_helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);

    // بحث شامل في كل الجداول
    final quranResults = await DBHelper.searchQuran(query);
    final duasResults = await DBHelper.searchDuas(query);
    final booksResults = await DBHelper.searchBooks(query);

    List<Map<String, dynamic>> combined = [];
    
    for (var item in quranResults) {
      combined.add({...item, 'source_type': 'قرآن'});
    }
    for (var item in duasResults) {
      combined.add({...item, 'source_type': 'دعاء'});
    }
    for (var item in booksResults) {
      combined.add({...item, 'source_type': 'مكتبة'});
    }

    setState(() {
      _searchResults = combined;
      _isSearching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'ابحث في القرآن، الأدعية، والمكتبة...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
          ),
          onChanged: _performSearch,
        ),
      ),
      body: _isSearching
          ? const Center(child: CircularProgressIndicator())
          : _searchResults.isEmpty
              ? const Center(child: Text('لا توجد نتائج للبحث.'))
              : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final item = _searchResults[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: Text(item['source_type'] == 'قرآن' ? 'ق' : item['source_type'] == 'دعاء' ? 'د' : 'م', style: const TextStyle(color: Colors.green)),
                      ),
                      title: Text(item['title'] ?? 'بدون عنوان', style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        (item['content'] ?? item['text'] ?? '').replaceAll('\n', ' '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(item['source_type'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    );
                  },
                ),
    );
  }
}
