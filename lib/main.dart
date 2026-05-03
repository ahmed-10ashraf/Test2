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
                primaryColor: const Color(0xFF1565C0),
                scaffoldBackgroundColor: Colors.white,
                cardColor: Colors.white,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xFF1565C0),
                  primary: const Color(0xFF1565C0),
                  secondary: const Color(0xFF42A5F5),
                  surface: Colors.white,
                  outline: const Color(0xFFE3F2FD),
                ),
                useMaterial3: true,
              ),
              // الثيم الداكن (أسود وأزرق احترافي)
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primaryColor: const Color(0xFF1E88E5),
                scaffoldBackgroundColor: const Color(0xFF0B0F14),
                cardColor: const Color(0xFF121821),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFF121821),
                  elevation: 0,
                  centerTitle: true,
                ),
                colorScheme: ColorScheme.fromSeed(
                  brightness: Brightness.dark,
                  seedColor: const Color(0xFF1E88E5),
                  primary: const Color(0xFF1E88E5),
                  secondary: const Color(0xFF42A5F5),
                  surface: const Color(0xFF121821),
                  outline: const Color(0xFF1E1E1E),
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88E5),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Color(0xFFE3F2FD)),
                  bodyMedium: TextStyle(color: Color(0xFFB0BEC5)),
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
