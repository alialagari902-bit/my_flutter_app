import 'package:flutter/material.dart';
import 'screens/main_navigation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RejalAllahApp());
}

class RejalAllahApp extends StatelessWidget {
  const RejalAllahApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'رجال الله',
      debugShowCheckedModeBanner: false,
      // دعم اللغة العربية والاتجاه من اليمين لليسار (RTL)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // العربية
      ],
      locale: const Locale('ar', 'AE'),
      theme: ThemeData(
        primaryColor: const Color(0xFF1B5E20), // أخضر إسلامي
        scaffoldBackgroundColor: const Color(0xFFF1F8E9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B5E20),
          centerTitle: true,
          elevation: 0,
        ),
        fontFamily: 'Tajawal', // يفضل إضافة خط عربي جميل لاحقاً
      ),
      home: const MainNavigation(),
    );
  }
}
