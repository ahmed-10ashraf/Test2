import 'package:flutter/material.dart';
import 'package:test2/main.dart';
import 'package:test2/models/car_ad.dart';

class CarDetailsScreen extends StatelessWidget {
  final CarAd car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isAr = locale.languageCode == 'ar';
        
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, isDark, isAr),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(isAr, isDark),
                      const SizedBox(height: 25),
                      _buildSpecifications(isAr, isDark),
                      const SizedBox(height: 25),
                      _buildDescription(isAr, isDark),
                      const SizedBox(height: 25),
                      _buildSellerInfo(isAr, isDark),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: _buildBottomAction(isAr, isDark, context),
        );
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark, bool isAr) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black26,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.favorite_border, color: Colors.white),
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.share, color: Colors.white),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: car.imagePath.startsWith('assets/')
            ? Image.asset(car.imagePath, fit: BoxFit.cover)
            : Image.network(car.imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildHeader(bool isAr, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                isAr ? car.titleAr : car.titleEn,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? Colors.white10 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: car.brandLogo.startsWith('http')
                  ? Image.network(car.brandLogo, height: 30, width: 30)
                  : Image.asset(car.brandLogo, height: 30, width: 30),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          isAr ? car.priceAr : car.priceEn,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A73E8),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              isAr ? 'القاهرة، مصر' : 'Cairo, Egypt',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(width: 15),
            Icon(Icons.access_time, size: 16, color: Colors.grey),
            const SizedBox(width: 4),
            Text(
              isAr ? 'منذ يومين' : '2 days ago',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecifications(bool isAr, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isAr ? 'المواصفات' : 'Specifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: [
            _buildSpecItem(Icons.speed, isAr ? 'كم' : 'KM', '0', isDark),
            _buildSpecItem(Icons.calendar_today, isAr ? 'السنة' : 'Year', '2024', isDark),
            _buildSpecItem(Icons.settings, isAr ? 'ناقل الحركة' : 'Transmission', isAr ? 'أوتوماتيك' : 'Auto', isDark),
            _buildSpecItem(Icons.local_gas_station, isAr ? 'الوقود' : 'Fuel', isAr ? 'بنزين' : 'Petrol', isDark),
            _buildSpecItem(Icons.color_lens, isAr ? 'اللون' : 'Color', isAr ? 'أبيض' : 'White', isDark),
            _buildSpecItem(Icons.settings_suggest_outlined, isAr ? 'المحرك' : 'Engine', '1600 CC', isDark),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecItem(IconData icon, String label, String value, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF1A73E8)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(bool isAr, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isAr ? 'الوصف' : 'Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isAr ? car.detailsAr : car.detailsEn,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isAr 
            ? 'هذا النص هو مثال لوصف السيارة بالتفصيل. يتم عرض كافة المميزات والاضافات الموجودة في السيارة هنا.'
            : 'This is a sample text for a detailed car description. All features and additions to the car are displayed here.',
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildSellerInfo(bool isAr, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? Colors.white10 : Colors.grey.shade200),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFF1A73E8).withValues(alpha: 0.1),
            child: Icon(Icons.person, color: const Color(0xFF1A73E8)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAr ? 'محمد أحمد' : 'Mohamed Ahmed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  isAr ? 'بائع موثوق' : 'Verified Seller',
                  style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(isAr ? 'عرض الملف' : 'View Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(bool isAr, bool isDark, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.chat_bubble_outline),
              label: Text(isAr ? 'محادثة' : 'Chat'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.white10 : Colors.grey.shade100,
                foregroundColor: isDark ? Colors.white : Colors.black87,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.phone_outlined),
              label: Text(isAr ? 'اتصال' : 'Call'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A73E8),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
