import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:math' as math;

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({Key? key}) : super(key: key);

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  // زاوية القبلة لمدينة صنعاء كمثال (حوالي 136 درجة من الشمال)
  // في التطبيق الفعلي سيتم حسابها عبر إحداثيات الـ GPS باستخدام معادلات جغرافية
  final double _qiblaDirection = 136.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('اتجاه القبلة', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder<CompassEvent>(
        stream: FlutterCompass.events,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('خطأ في قراءة المستشعر'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          double? direction = snapshot.data?.heading;

          if (direction == null) {
            return const Center(child: Text('جهازك لا يدعم مستشعر البوصلة'));
          }

          // حساب زاوية دوران صورة البوصلة لتشير إلى القبلة
          double qiblaAngle = (_qiblaDirection - direction) * (math.pi / 180);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('قم بتدوير الهاتف حتى يتطابق السهم مع الكعبة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
              const SizedBox(height: 50),
              Stack(
                alignment: Alignment.center,
                children: [
                  // إطار البوصلة (الشمال دائماً للأعلى في الهاتف)
                  Transform.rotate(
                    angle: (direction * (math.pi / 180) * -1),
                    child: Icon(Icons.explore_outlined, size: 300, color: Colors.green.shade200),
                  ),
                  // مؤشر القبلة
                  Transform.rotate(
                    angle: qiblaAngle,
                    child: const Icon(Icons.arrow_upward, size: 100, color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Text('الزاوية الحالية: ${direction.toStringAsFixed(0)}°',
                  style: const TextStyle(fontSize: 18, color: Colors.grey)),
            ],
          );
        },
      ),
    );
  }
}
