import 'package:flutter/material.dart';
import 'package:test2/main.dart';
import 'dart:io';
import '../auth/login_page.dart';
import 'edit_profile_screen.dart';
import 'my_ads_screen.dart';
import 'favorites_screen.dart';
import 'upgrade_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isAr = locale.languageCode == 'ar';
        
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header with Gradient and Member Badge
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 60, bottom: 30),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF00D2A0),
                        Color(0xFF1A73E8),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      ValueListenableBuilder<String?>(
                        valueListenable: userProfileImageNotifier,
                        builder: (context, imagePath, _) {
                          return Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: imagePath != null
                                  ? Image.file(File(imagePath), fit: BoxFit.cover)
                                  : Container(
                                      color: Colors.white24,
                                      child: const Icon(Icons.person, size: 60, color: Colors.white),
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Mohamed Ahmed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.orange, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              isAr ? 'عضو قياسي' : 'Standard Member',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Stats Row
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              )
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(context, '3', isAr ? 'إعلانات نشطة' : 'Active Ads'),
                              Container(width: 1, height: 40, color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                              _buildStatItem(context, '12', isAr ? 'المفضلة' : 'Favorites'),
                              Container(width: 1, height: 40, color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
                              _buildStatItem(context, '4.8', isAr ? 'التقييم' : 'Rating'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Menu Items
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildMenuItem(
                        context,
                        Icons.edit,
                        isAr ? 'تعديل الملف الشخصي' : 'Edit Profile',
                        iconColor: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        Icons.assignment_outlined,
                        isAr ? 'إعلاناتي' : 'My Ads',
                        badge: '0',
                        iconColor: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyAdsScreen()),
                          );
                        },
                      ),
                      _buildMenuItem(
                        context,
                        Icons.favorite,
                        isAr ? 'المفضلة' : 'Favorites',
                        iconColor: Colors.pink,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                          );
                        },
                      ),
                      _buildThemeToggle(context),
                      _buildLanguageItem(context),
                      _buildUpgradeItem(context),
                      _buildMenuItem(context, Icons.support_agent, isAr ? 'الدعم والأسئلة الشائعة' : 'Support & FAQ', iconColor: Colors.orangeAccent),
                      _buildMenuItem(
                        context,
                        Icons.logout,
                        isAr ? 'تسجيل الخروج' : 'Logout',
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        showArrow: false,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(isAr ? 'تسجيل الخروج' : 'Logout'),
                              content: Text(isAr ? 'هل أنت متأكد من تسجيل الخروج؟' : 'Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(isAr ? 'إلغاء' : 'Cancel', style: TextStyle(color: isDark ? Colors.white70 : Colors.grey)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => const LoginPage()),
                                      (route) => false,
                                    );
                                  },
                                  child: Text(isAr ? 'نعم' : 'Yes', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1A73E8)),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12, 
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey, 
            fontWeight: FontWeight.w500
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      {String? badge, String? trailingText, Color? iconColor, Color? textColor, bool showArrow = true, VoidCallback? onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.1 : 0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (iconColor ?? Colors.blue).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor ?? Colors.blue, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: textColor ?? (isDark ? Colors.white : Colors.black87),
                ),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            if (trailingText != null)
              Text(
                trailingText,
                style: TextStyle(color: isDark ? Colors.white60 : Colors.grey, fontSize: 14),
              ),
            if (showArrow)
              Icon(Icons.chevron_right, color: isDark ? Colors.white30 : Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr = localeNotifier.value.languageCode == 'ar';

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.brightness_2, color: Colors.orange, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              isAr ? 'وضع المظهر' : 'Theme Mode',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ),
          Switch(
            value: isDark,
            onChanged: (val) {
              themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light;
            },
            activeThumbColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, currentLocale, _) {
        return InkWell(
          onTap: () {
            _showLanguageDialog(context);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.language, color: Colors.teal, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    currentLocale.languageCode == 'en' ? 'Language' : 'اللغة',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
                Text(
                  currentLocale.languageCode == 'en' ? 'English' : 'العربية',
                  style: TextStyle(color: isDark ? Colors.white60 : Colors.grey, fontSize: 14),
                ),
                Icon(Icons.chevron_right, color: isDark ? Colors.white30 : Colors.grey, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language / اختر اللغة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              leading: Radio<String>(
                value: 'en',
                groupValue: localeNotifier.value.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    localeNotifier.value = const Locale('en');
                    Navigator.pop(context);
                  }
                },
              ),
              onTap: () {
                localeNotifier.value = const Locale('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('العربية'),
              leading: Radio<String>(
                value: 'ar',
                groupValue: localeNotifier.value.languageCode,
                onChanged: (value) {
                  if (value != null) {
                    localeNotifier.value = const Locale('ar');
                    Navigator.pop(context);
                  }
                },
              ),
              onTap: () {
                localeNotifier.value = const Locale('ar');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpgradeItem(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr = localeNotifier.value.languageCode == 'ar';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpgradeScreen()),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.1 : 0.02),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.card_giftcard, color: Colors.amber, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? 'الترقية للنسخة المميزة' : 'Upgrade to Premium',
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    isAr ? 'عزز إعلاناتك واحصل على الأولوية' : 'Boost your listings & get priority',
                    style: TextStyle(fontSize: 12, color: isDark ? Colors.white60 : Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: isDark ? Colors.white30 : Colors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
