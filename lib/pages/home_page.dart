import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _bannerData = [
    {
      'title': 'Summer Offer from Hyundai',
      'subtitle': 'The strongest summer offers in Egypt',
      'image': 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=800',
      'cta': 'Learn More'
    },
    {
      'title': 'Find Your Dream Car',
      'subtitle': 'Up to 30% Off Listings',
      'image': 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=800',
      'cta': 'Browse Deals'
    },
    {
      'title': 'Sell Your Car Fast',
      'subtitle': 'Get the best market price',
      'image': 'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?auto=format&fit=crop&q=80&w=800',
      'cta': 'List Now'
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _bannerData.length - 1) {
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
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildTopBar(),
                const SizedBox(height: 20),
                _buildSearchBar(),
                const SizedBox(height: 25),
                _buildBannerCarousel(),
                const SizedBox(height: 25),
                
                // Top Brands Section
                _buildTopBrandsSection(),
                
                const SizedBox(height: 25),
                // Categories (SUV, Sedan, etc.)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryItem('Sedans', 'https://images.unsplash.com/photo-1617469767053-d3b523a0b982?auto=format&fit=crop&q=80&w=200', const Color(0xFFE3F2FD)),
                    _buildCategoryItem('SUVs', 'https://images.unsplash.com/photo-1519641471654-76ce0107ad1b?auto=format&fit=crop&q=80&w=200', const Color(0xFFE0F2F1)),
                    _buildCategoryItem('Hatchback', 'https://images.unsplash.com/photo-1590362891175-3794ef169f2a?auto=format&fit=crop&q=80&w=200', const Color(0xFFFFF3E0)),
                    _buildCategoryItem('Sports', 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&q=80&w=200', const Color(0xFFF3E5F5)),
                  ],
                ),

                const SizedBox(height: 25),
                // Featured Cars Header
                _buildSectionHeader('Featured Cars', Icons.stars, Colors.orangeAccent),
                const SizedBox(height: 15),
                // Featured Cars List
                SizedBox(
                  height: 260,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCarCard(
                        'Audi A6 Sedan', 
                        '2023 · 0 km · Auto', 
                        'EGP 3,850,000', 
                        'https://images.unsplash.com/photo-1541348263662-e0c8de4259ba?auto=format&fit=crop&q=80&w=400',
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Audi-Logo_2016.svg/1024px-Audi-Logo_2016.svg.png'
                      ),
                      const SizedBox(width: 15),
                      _buildCarCard(
                        'Porsche 911 GT3', 
                        '2024 · 0 km · PDK', 
                        'EGP 12,500,000', 
                        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=400',
                        'https://upload.wikimedia.org/wikipedia/en/thumb/d/d9/Porsche_logo.svg/800px-Porsche_logo.svg.png'
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                _buildSectionHeader('Showrooms', Icons.business, Colors.blueGrey),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _buildShowroomPlaceholder(),
                    const SizedBox(width: 15),
                    _buildShowroomPlaceholder(),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildTopBrandsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Top Brands',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text(
                  'View All',
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 12, color: Colors.orange.shade700),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBrandItem('Mercedes', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Mercedes-Benz_Logo_2010.svg/1024px-Mercedes-Benz_Logo_2010.svg.png'),
            _buildBrandItem('BMW', 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/BMW.svg/1024px-BMW.svg.png'),
            _buildBrandItem('Audi', 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Audi-Logo_2016.svg/1024px-Audi-Logo_2016.svg.png'),
            _buildBrandItem('Porsche', 'https://upload.wikimedia.org/wikipedia/en/thumb/d/d9/Porsche_logo.svg/800px-Porsche_logo.svg.png'),
          ],
        ),
      ],
    );
  }

  Widget _buildBrandItem(String name, String logoUrl) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Image.network(
            logoUrl,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, color: Colors.grey),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _bannerData.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    children: [
                      Image.network(
                        _bannerData[index]['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _bannerData[index]['title']!.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _bannerData[index]['subtitle']!,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A73E8),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                '${_bannerData[index]['cta']} →',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _bannerData.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? const Color(0xFF1A73E8) : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'CAR ',
                    style: TextStyle(
                      color: Color(0xFF1A73E8),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: 'LINK',
                    style: TextStyle(
                      color: Color(0xFF00D2A0),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: const [
                Icon(Icons.location_on, size: 14, color: Colors.redAccent),
                SizedBox(width: 4),
                Text(
                  'Cairo, Egypt',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            _buildIconButton(Icons.notifications_none, Colors.orangeAccent, hasDot: true),
            const SizedBox(width: 12),
            _buildIconButton(Icons.favorite, Colors.pinkAccent),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, Color iconColor, {bool hasDot = false}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Icon(icon, color: iconColor),
        ),
        if (hasDot)
          Positioned(
            right: 2,
            top: 2,
            child: Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
            ),
          )
      ],
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
            ),
            child: Row(
              children: const [
                Icon(Icons.search, color: Color(0xFF1A73E8)),
                SizedBox(width: 10),
                Text('Search cars, brands, models...', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        const Text('Filter', style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.bold)),
        const SizedBox(width: 4),
        const Icon(Icons.settings_input_component, size: 18, color: Color(0xFF1A73E8)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        const Text('See all', style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildShowroomPlaceholder() {
    return Container(
      width: 100,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: const Icon(Icons.apartment, size: 40, color: Colors.blueGrey),
    );
  }

  Widget _buildBottomNavBar() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', true),
              _buildNavItem(Icons.chat_bubble_outline, 'Chatbot', false),
              const SizedBox(width: 40),
              _buildNavItem(Icons.menu, 'Services', false),
              _buildNavItem(Icons.person_outline, 'Profile', false),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
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
      ],
    );
  }

  Widget _buildCategoryItem(String title, String imageUrl, Color bgColor) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: bgColor, 
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildCarCard(String name, String details, String price, String carImageUrl, String brandLogoUrl) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Image.network(
                    carImageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(brandLogoUrl, height: 20, width: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
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
    );
  }
}
