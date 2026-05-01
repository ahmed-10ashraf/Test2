import 'package:flutter/material.dart';
import 'package:test2/main.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isAr = locale.languageCode == 'ar';
        
        return Scaffold(
          appBar: AppBar(
            title: Text(isAr ? 'الإشعارات' : 'Notifications'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  size: 80,
                  color: Colors.grey.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  isAr ? 'لا توجد إشعارات حالياً' : 'No notifications yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
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
