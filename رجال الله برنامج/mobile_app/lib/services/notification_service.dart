import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await _notificationsPlugin.initialize(initializationSettings);
  }

  // جدولة إشعار الصلاة
  static Future<void> schedulePrayerNotification(int id, String title, String body, DateTime scheduledTime) async {
    await _notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledTime, tz.local),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'prayer_channel', 'مواقيت الصلاة',
                channelDescription: 'تنبيهات دخول أوقات الصلاة',
                importance: Importance.max,
                priority: Priority.high,
                sound: RawResourceAndroidNotificationSound('athan'))), // ملف الأذان يجب أن يكون في raw
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  // جدولة تذكير الـ 10 أيام
  static Future<void> schedule10DayReminder() async {
    await _notificationsPlugin.zonedSchedule(
        999,
        'تذكير إيماني',
        'حان وقت الإنفاق في سبيل الله وزيارة روضة الشهداء.',
        tz.TZDateTime.now(tz.local).add(const Duration(days: 10)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'reminder_channel', 'التذكير الدوري',
                channelDescription: 'تذكير كل 10 أيام بالأعمال الإيمانية',
                importance: Importance.high,
                priority: Priority.high)),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
  }

  static Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }
}
