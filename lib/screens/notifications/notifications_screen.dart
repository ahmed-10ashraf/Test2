import 'package:flutter/material.dart';
import 'package:test2/main.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isAr = locale.languageCode == 'ar';
        
        return Scaffold(
          appBar: AppBar(
            title: Text(isAr ? 'الإشعارات' : 'Notifications', style: const TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none_outlined,
                    size: 80,
                    color: Color(0xFF1565C0),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  isAr ? 'لا توجد إشعارات حالياً' : 'No notifications yet',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isAr ? 'سنقوم بإخطارك عند وجود تحديثات جديدة' : 'We will notify you when there are new updates',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

