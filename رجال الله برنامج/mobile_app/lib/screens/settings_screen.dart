import 'package:flutter/material.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _enableAthan = true;
  bool _enable10DayReminder = true;
  bool _darkMode = false;
  double _fontSize = 18.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات والتذكيرات', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('التنبيهات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          SwitchListTile(
            title: const Text('تفعيل الأذان الصوتي'),
            subtitle: const Text('تنبيه عند دخول وقت كل صلاة'),
            value: _enableAthan,
            activeColor: Colors.green,
            onChanged: (val) => setState(() => _enableAthan = val),
          ),
          SwitchListTile(
            title: const Text('تذكير الـ 10 أيام'),
            subtitle: const Text('تذكير دوري بالإنفاق في سبيل الله وزيارة روضة الشهداء'),
            value: _enable10DayReminder,
            activeColor: Colors.green,
            onChanged: (val) => setState(() => _enable10DayReminder = val),
          ),
          const Divider(),
          const Text('المظهر والوصول', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          SwitchListTile(
            title: const Text('الوضع الليلي'),
            subtitle: const Text('إراحة العين أثناء القراءة'),
            value: _darkMode,
            activeColor: Colors.green,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          ListTile(
            title: const Text('حجم الخط'),
            subtitle: Text('حجم الخط الحالي للاستخدام: ${_fontSize.toInt()}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () { if (_fontSize > 12) setState(() => _fontSize -= 2); }),
                IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () { if (_fontSize < 30) setState(() => _fontSize += 2); }),
              ],
            ),
          ),
          const Divider(),
          const Text('الخصوصية والمعلومات', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('سياسة الخصوصية'),
            subtitle: const Text('تعرف على كيفية حماية بياناتك'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('تطبيق رجال الله'),
            subtitle: const Text('الإصدار 1.0 (بدون إنترنت)'),
          ),
        ],
      ),
    );
  }
}
