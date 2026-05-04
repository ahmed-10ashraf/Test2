import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/splash_screen/splash_page.dart';

// Global notifiers for theme, user profile image, and locale.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<String?> userProfileImageNotifier = ValueNotifier<String?>(null);
final ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('en'));

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder2<ThemeMode, Locale>(
      first: themeNotifier,
      second: localeNotifier,
      builder: (context, currentMode, currentLocale, child) {
        return MaterialApp(
          title: 'Car Link',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          locale: currentLocale,
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          // Light Theme (Premium Blue)
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: const Color(0xFF1E88E5),
            scaffoldBackgroundColor: Colors.white,
            cardColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1E88E5),
              primary: const Color(0xFF1E88E5),
              secondary: const Color(0xFF42A5F5),
              surface: Colors.white,
              outline: const Color(0xFFE3F2FD),
            ),
            useMaterial3: true,
          ),
          // Dark Theme (Professional Dark Blue)
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
  }
}

// Simple helper for multiple ValueListenables
class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    super.key,
    required this.first,
    required this.second,
    required this.builder,
    this.child,
  });

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget Function(BuildContext context, A a, B b, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<A>(
        valueListenable: first,
        builder: (context, a, _) => ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, _) => builder(context, a, b, child),
        ),
      );
}
