import 'package:flutter/material.dart';

class WuduPrayerScreen extends StatelessWidget {
  const WuduPrayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصلاة والوضوء', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionCard(
            title: 'كيفية الوضوء',
            icon: Icons.water_drop,
            content: '1. النية.\n2. غسل الوجه.\n3. غسل اليدين إلى المرفقين.\n4. مسح الرأس.\n5. غسل القدمين أو مسحهما (حسب المذهب).',
          ),
          const SizedBox(height: 10),
          _buildSectionCard(
            title: 'مبطلات الوضوء',
            icon: Icons.warning_amber,
            content: 'كل ما يخرج من السبيلين، النوم العميق، زوال العقل.',
          ),
          const SizedBox(height: 10),
          _buildSectionCard(
            title: 'أركان الصلاة',
            icon: Icons.accessibility_new,
            content: 'النية، تكبيرة الإحرام، القيام، قراءة الفاتحة، الركوع، السجود، الجلوس الأخير.',
          ),
          const SizedBox(height: 10),
          _buildSectionCard(
            title: 'الأذكار بعد الصلاة',
            icon: Icons.record_voice_over,
            content: 'تسبيح الزهراء (عليها السلام): الله أكبر (34)، الحمد لله (33)، سبحان الله (33).\nوآية الكرسي.',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required String content}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: const TextStyle(fontSize: 15, height: 1.5),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
