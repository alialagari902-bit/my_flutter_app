import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // In a real app, this will load IDs from SharedPreferences and query SQLite
    return Scaffold(
      appBar: AppBar(
        title: const Text('المفضلة', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: const Center(
        child: Text(
          'لا توجد عناصر مفضلة بعد.\nيمكنك إضافة الأدعية والسور والكتب إلى المفضلة لاحقاً.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
