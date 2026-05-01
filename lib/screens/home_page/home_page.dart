import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:test2/main.dart';
import 'package:test2/data/dummy_data.dart';
import 'package:test2/models/car_ad.dart';
import '../profile/profile_screen.dart';
import '../profile/my_ads_screen.dart';
import '../profile/favorites_screen.dart';
import '../notifications/notifications_screen.dart';
import '../filter/filter_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  void _startBannerTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      final bannersCount = bannersEn.length;
      if (_currentPage < bannersCount - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        final isAr = locale.languageCode == 'ar';
        
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: IndexedStack(
            index: _selectedIndex,
            children: [
              _buildHomeContent(isDark, isAr),
              Center(child: Text(isAr ? 'شاشة البوت' : 'Chatbot Screen')),
              _buildHomeContent(isDark, isAr),
              Center(child: Text(isAr ? 'الخدمات' : 'Services Screen')),
              const ProfileScreen(),
            ],
          ),
          bottomNavigationBar: _buildBottomNavBar(isDark, isAr),
        );
      },
    );
  }

  Widget _buildHomeContent(bool isDark, bool isAr) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildTopBar(isDark, isAr),
              const SizedBox(height: 20),
              _buildSearchBar(isDark, isAr),
              const SizedBox(height: 25),
              _buildBannerCarousel(isAr),
              const SizedBox(height: 25),
              _buildTopBrandsSection(isDark, isAr),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryItem(isAr ? 'سيدان' : 'Sedans', 'https://images.unsplash.com/photo-1617469767053-d3b523a0b982?auto=format&fit=crop&q=80&w=200', isDark ? Colors.blue.withValues(alpha: 0.1) : const Color(0xFFE3F2FD), isDark),
                  _buildCategoryItem(isAr ? 'دفع رباعي' : 'SUVs', 'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?auto=format&fit=crop&q=80&w=200', isDark ? Colors.teal.withValues(alpha: 0.1) : const Color(0xFFE0F2F1), isDark),
                  _buildCategoryItem(isAr ? 'هاتشباك' : 'Hatchback', 'https://images.unsplash.com/photo-1590362891175-3794ef169f2a?auto=format&fit=crop&q=80&w=200', isDark ? Colors.orange.withValues(alpha: 0.1) : const Color(0xFFFFF3E0), isDark),
                  _buildCategoryItem(isAr ? 'رياضية' : 'Sports', 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&q=80&w=200', isDark ? Colors.purple.withValues(alpha: 0.1) : const Color(0xFFF3E5F5), isDark),
                ],
              ),
              const SizedBox(height: 25),
              _buildSectionHeader(isAr ? 'سيارات مميزة' : 'Featured Cars', Icons.stars, Colors.orangeAccent, isDark, isAr),
              const SizedBox(height: 15),
              SizedBox(
                height: 280,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredCars.length,
                  itemBuilder: (context, index) {
                    final car = featuredCars[index];
                    return Padding(
                      padding: EdgeInsetsDirectional.only(end: 15),
                      child: _buildCarCard(
                        isAr ? car.titleAr : car.titleEn,
                        isAr ? car.detailsAr : car.detailsEn,
                        isAr ? car.priceAr : car.priceEn,
                        car.imagePath,
                        car.brandLogo,
                        isDark,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 25),
              _buildSectionHeader(isAr ? 'المعارض' : 'Showrooms', Icons.business, Colors.blueGrey, isDark, isAr),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildShowroomPlaceholder(isDark, isAr),
                  const SizedBox(width: 15),
                  _buildShowroomPlaceholder(isDark, isAr),
                ],
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(bool isDark, bool isAr) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, isAr ? 'الرئيسية' : 'Home', 0),
              _buildNavItem(Icons.chat_bubble_outline, isAr ? 'البوت' : 'Chatbot', 1),
              const SizedBox(width: 40),
              _buildNavItem(Icons.menu, isAr ? 'الخدمات' : 'Services', 3),
              _buildNavItem(Icons.person_outline, isAr ? 'حسابي' : 'Profile', 4),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = 2;
              });
            },
            child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF1A73E8),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1A73E8).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? const Color(0xFF1A73E8) : Colors.grey),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF1A73E8) : Colors.grey,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(bool isDark, bool isAr) {
    return Directionality(
      textDirection: TextDirection.ltr, // لضمان أن الصورة دائماً على اليسار والقلب على اليمين
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // صورة البروفايل في أقصى اليسار
          ValueListenableBuilder<String?>(
            valueListenable: userProfileImageNotifier,
            builder: (context, imagePath, _) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = 4; // ينتقل لتبويب الحساب
                  });
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF1A73E8), width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22.5),
                    child: imagePath != null
                        ? Image.file(File(imagePath), fit: BoxFit.cover)
                        : Container(
                            color: isDark ? Colors.white10 : Colors.grey.shade200,
                            child: Icon(Icons.person, color: isDark ? Colors.white54 : Colors.grey, size: 25),
                          ),
                  ),
                ),
              );
            },
          ),
          
          // أيقونات الإشعارات والمفضلة في اليمين
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05), blurRadius: 5),
                    ],
                  ),
                  child: const Icon(Icons.favorite, color: Colors.red, size: 22),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05), blurRadius: 5),
                    ],
                  ),
                  child: Icon(Icons.notifications_outlined, color: isDark ? Colors.white70 : Colors.black87),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isDark, bool isAr) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FilterScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.03), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: TextField(
          enabled: false, // تعطيل الكتابة ليقوم الـ GestureDetector بالتعامل مع الضغطة
          textAlign: isAr ? TextAlign.right : TextAlign.left,
          style: TextStyle(color: isDark ? Colors.white : Colors.black87),
          decoration: InputDecoration(
            icon: isAr ? null : const Icon(Icons.search, color: Colors.grey),
            suffixIcon: isAr ? const Icon(Icons.search, color: Colors.grey) : null,
            hintText: isAr ? 'ابحث عن الماركات، الموديلات...' : 'Search for brands, models...',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBannerCarousel(bool isAr) {
    final banners = isAr ? bannersAr : bannersEn;

    return Column(
      children: [
        SizedBox(
          height: 210,
          child: PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black,
                  image: DecorationImage(
                    image: banners[index]['image']!.startsWith('assets/')
                        ? AssetImage(banners[index]['image']!) as ImageProvider
                        : NetworkImage(banners[index]['image']!),
                    fit: BoxFit.cover,
                    alignment: isAr ? Alignment.centerLeft : Alignment.centerRight,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: isAr ? Alignment.centerRight : Alignment.centerLeft,
                      end: isAr ? Alignment.centerLeft : Alignment.centerRight,
                      stops: const [0.0, 0.5],
                      colors: [
                        Colors.black.withOpacity(0.85),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              banners[index]['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              banners[index]['subtitle']!,
                              style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12),
                            ),
                            const SizedBox(height: 18),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00D2A0),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              child: Text(banners[index]['cta']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 6),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(banners.length, (index) => _buildPageIndicator(index)),
        ),
      ],
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF1A73E8) : Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildTopBrandsSection(bool isDark, bool isAr) {
    final brands = [
      {'name': 'BMW', 'logo': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/1024px-BMW.svg.png'},
      {'name': 'Mercedes', 'logo': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Logo_2010.svg/1024px-Mercedes-Logo_2010.svg.png'},
      {'name': 'Tesla', 'logo': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Tesla_Motors.svg/1024px-Tesla_Motors.svg.png'},
      {'name': 'Audi', 'logo': 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Audi-Logo_2016.svg/1024px-Audi-Logo_2016.svg.png'},
      {'name': 'Toyota', 'logo': 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Toyota_EU.svg/1024px-Toyota_EU.svg.png'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(isAr ? 'أفضل الماركات' : 'Top Brands', Icons.local_fire_department, Colors.redAccent, isDark, isAr),
        const SizedBox(height: 15),
        SizedBox(
          height: 80,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(isDark ? 0.2 : 0.05), blurRadius: 5),
                      ],
                    ),
                    child: Image.network(brands[index]['logo']!),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    brands[index]['name']!, 
                    style: TextStyle(
                      fontSize: 12, 
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color iconColor, bool isDark, bool isAr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 8),
            Text(
              title, 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            isAr ? 'عرض الكل' : 'See All',
            style: const TextStyle(color: Color(0xFF1A73E8)),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, String imageUrl, Color bgColor, bool isDark) {
    return Column(
      children: [
        Container(
          height: 70,
          width: 75,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(imageUrl, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title, 
          style: TextStyle(
            fontSize: 13, 
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildCarCard(String title, String details, String price, String imageUrl, String brandLogoUrl, bool isDark) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(isDark ? 0.3 : 0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                child: AspectRatio(
                  aspectRatio: 1.7,
                  child: imageUrl.startsWith('assets/')
                    ? Image.asset(imageUrl, fit: BoxFit.cover)
                    : Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
              PositionedDirectional(
                top: 12,
                end: 12,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                      ),
                      child: brandLogoUrl.startsWith('http')
                        ? Image.network(brandLogoUrl, height: 18, width: 18)
                        : Image.asset(brandLogoUrl, height: 18, width: 18),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 16,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(details, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Text(price, style: const TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowroomPlaceholder(bool isDark, bool isAr) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isDark ? Colors.white10 : Colors.grey.withOpacity(0.1)),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store, color: Colors.grey),
              Text(
                isAr ? 'قريباً' : 'Coming Soon',
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
