import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "sql_app.db");

    // تحقق مما إذا كانت قاعدة البيانات موجودة في الهاتف
    var exists = await databaseExists(path);

    if (!exists) {
      // إذا لم تكن موجودة، قم بنسخها من مجلد assets (الذي تم تجميعه مع التطبيق بدون نت)
      print("جاري نسخ قاعدة البيانات لأول مرة...");
      
      // تأكد من وجود المجلد
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // نسخ الملف من assets
      ByteData data = await rootBundle.load(url.join("assets", "db", "sql_app.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      
      // كتابة الملف في مسار الهاتف
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("قاعدة البيانات موجودة مسبقاً.");
    }

    // فتح قاعدة البيانات
    return await openDatabase(path, version: 1);
  }

  // دالة لجلب الأدعية
  static Future<List<Map<String, dynamic>>> getDuas() async {
    final db = await database;
    return await db.query('duas');
  }

  // دالة لجلب الكتب / الملازم
  static Future<List<Map<String, dynamic>>> getBooks() async {
    final db = await database;
    return await db.query('books');
  }

  // دالة لجلب سور القرآن الكريم
  static Future<List<Map<String, dynamic>>> getQuran() async {
    final db = await database;
    return await db.query('quran', orderBy: 'surah_number ASC');
  }

  // دوال البحث الشامل
  static Future<List<Map<String, dynamic>>> searchQuran(String query) async {
    final db = await database;
    return await db.query('quran', where: 'title LIKE ? OR content LIKE ?', whereArgs: ['%$query%', '%$query%'], limit: 10);
  }

  static Future<List<Map<String, dynamic>>> searchDuas(String query) async {
    final db = await database;
    return await db.query('duas', where: 'title LIKE ? OR text LIKE ?', whereArgs: ['%$query%', '%$query%'], limit: 10);
  }

  static Future<List<Map<String, dynamic>>> searchBooks(String query) async {
    final db = await database;
    return await db.query('books', where: 'title LIKE ? OR content LIKE ?', whereArgs: ['%$query%', '%$query%'], limit: 10);
  }
}
