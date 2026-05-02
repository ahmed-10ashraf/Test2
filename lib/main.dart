import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash_screen/splash_page.dart';

// متحكم عام لتغيير الثيم واللغة وصورة الملف الشخصي
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));
final ValueNotifier<String?> userProfileImageNotifier = ValueNotifier<String?>(null);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, currentLocale, child) {
            return MaterialApp(
              title: 'Car Link',
              debugShowCheckedModeBanner: false,
              themeMode: currentMode,
              locale: currentLocale,
              // دعم اللغات
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // الثيم الفاتح (أبيض وأزرق)
              theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: const Color(0xFF1A73E8),
                scaffoldBackgroundColor: const Color(0xFFF8FAFF),
                cardColor: Colors.white,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF1A73E8),
                  primary: const Color(0xFF1A73E8),
                  surface: Colors.white,
                ),
                useMaterial3: true,
              ),
              // الثيم الداكن (أسود وأزرق)
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0xFF1A73E8),
                scaffoldBackgroundColor: Colors.black,
                cardColor: const Color(0xFF121212),
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: const Color(0xFF1A73E8),
                  primary: const Color(0xFF1A73E8),
                  surface: const Color(0xFF121212),
                ),
                useMaterial3: true,
              ),
              home: const SplashPage(),
            );
          },
        );
      },
    );
  }
}
