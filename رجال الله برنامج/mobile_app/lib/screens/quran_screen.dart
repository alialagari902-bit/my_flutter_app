import 'package:flutter/material.dart';
import '../db_helper.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<Map<String, dynamic>> surahs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuran();
  }

  Future<void> _loadQuran() async {
    final localSurahs = await DBHelper.getQuran();
    setState(() {
      surahs = localSurahs;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : surahs.isEmpty
              ? const Center(child: Text('جاري تحميل المصحف...'))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: surahs.length,
                  itemBuilder: (context, index) {
                    final surah = surahs[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: ExpansionTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          child: Text(
                            surah['surah_number'].toString(),
                            style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                          ),
                        ),
                        title: Text(
                          surah['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text('${surah['type']} - آياتها: ${surah['ayahs_count']}'),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade50,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Text(
                              surah['content'] ?? '',
                              style: const TextStyle(
                                fontSize: 22,
                                height: 1.8,
                                fontFamily: 'Uthmani', // يفضل إضافة خط عثماني للمصحف
                              ),
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
