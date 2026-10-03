import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import '../db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PrayerTimes? prayerTimes;
  List<Map<String, dynamic>> duas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _calculateOfflinePrayerTimes();
    _loadLocalData();
  }

  // حساب مواقيت الصلاة بدون إنترنت (فلكياً بناء على الإحداثيات)
  void _calculateOfflinePrayerTimes() {
    // إحداثيات افتراضية (صنعاء كمثال) - يمكن لاحقاً أخذها من الـ GPS
    final myCoordinates = Coordinates(15.3694, 44.1910);
    
    // تحديد طريقة الحساب (مثلاً أم القرى أو مكة)
    final params = CalculationMethod.umm_al_qura.getParameters();
    params.madhab = Madhab.shafi;

    prayerTimes = PrayerTimes.today(myCoordinates, params);
  }

  // جلب البيانات من ملف SQLite المدمج
  Future<void> _loadLocalData() async {
    final localDuas = await DBHelper.getDuas();
    setState(() {
      duas = localDuas;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // بطاقة مواقيت الصلاة
                  _buildPrayerCard(),
                  const SizedBox(height: 20),
                  // قسم الأدعية من قاعدة البيانات
                  const Text('الأدعية المتاحة (بدون نت)', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildDuasList(),
                ],
              ),
            ),
    );
  }

  Widget _buildPrayerCard() {
    if (prayerTimes == null) return const SizedBox();
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('مواقيت الصلاة اليوم', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            _prayerRow('الفجر', prayerTimes!.fajr),
            _prayerRow('الظهر', prayerTimes!.dhuhr),
            _prayerRow('العصر', prayerTimes!.asr),
            _prayerRow('المغرب', prayerTimes!.maghrib),
            _prayerRow('العشاء', prayerTimes!.isha),
          ],
        ),
      ),
    );
  }

  Widget _prayerRow(String name, DateTime time) {
    // تنسيق الوقت البسيط
    String formattedTime = "${time.hour > 12 ? time.hour - 12 : time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'م' : 'ص'}";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(formattedTime, style: const TextStyle(fontSize: 16, color: Colors.green)),
        ],
      ),
    );
  }

  Widget _buildDuasList() {
    if (duas.isEmpty) return const Text('لا توجد أدعية حالياً');
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: duas.length,
      itemBuilder: (context, index) {
        final dua = duas[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.green),
            title: Text(dua['title']),
            subtitle: Text(
              dua['text'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }
}
