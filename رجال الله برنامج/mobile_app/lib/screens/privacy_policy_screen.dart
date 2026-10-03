import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سياسة الخصوصية وحماية البيانات', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('مقدمة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green)),
            SizedBox(height: 10),
            Text('نحن في تطبيق "رجال الله" نلتزم بحماية خصوصية مستخدمينا. هذا التطبيق صُمم ليكون منصة إيمانية آمنة تعمل بدون إنترنت وبدون تتبع.'),
            SizedBox(height: 20),
            Text('1. استخدام الموقع الجغرافي (GPS)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
            SizedBox(height: 10),
            Text('يطلب التطبيق صلاحية الوصول إلى الموقع الجغرافي لغرض واحد فقط وهو: حساب مواقيت الصلاة واتجاه القبلة بدقة. لا يتم إرسال موقعك لأي خادم ولا يتم تخزينه أبداً.'),
            SizedBox(height: 20),
            Text('2. حماية البيانات المحلية', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
            SizedBox(height: 10),
            Text('جميع بياناتك مثل (الأدعية المفضلة، آخر موضع قراءة، وإعدادات التنبيهات) يتم حفظها داخل هاتفك فقط. التطبيق لا يحتوي على نظام تتبع ولا يشارك أي بيانات مع أطراف خارجية.'),
            SizedBox(height: 20),
            Text('3. اختيار المدينة يدوياً', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
            SizedBox(height: 10),
            Text('إذا كنت لا ترغب في تفعيل الـ GPS، يمكنك اختيار مدينتك يدوياً من الإعدادات وسيعمل التطبيق بكفاءة تامة.'),
          ],
        ),
      ),
    );
  }
}
