import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                // Top Bar
                Row(
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
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: const Icon(Icons.notifications_none, color: Colors.orangeAccent),
                            ),
                            Positioned(
                              right: 2,
                              top: 2,
                              child: Container(
                                height: 8,
                                width: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: const Icon(Icons.favorite, color: Colors.pinkAccent),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                            )
                          ],
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.search, color: Color(0xFF1A73E8)),
                            SizedBox(width: 10),
                            Text(
                              'Search cars, brands, models...',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Filter',
                      style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.settings_input_component, size: 18, color: Color(0xFF1A73E8)),
                  ],
                ),
                const SizedBox(height: 25),
                // Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A73E8), Color(0xFF0D47A1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LIMITED TIME OFFER',
                            style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Find Your Dream Car\nUp to 30% Off Listings',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              'Browse Deals →',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Opacity(
                          opacity: 0.5,
                          child: Icon(Icons.directions_car, size: 80, color: Colors.blue.shade900),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCategoryItem('Sedans', Icons.directions_car, const Color(0xFFE3F2FD)),
                    _buildCategoryItem('SUVs', Icons.airport_shuttle, const Color(0xFFE0F2F1)),
                    _buildCategoryItem('Vans', Icons.bus_alert, const Color(0xFFFFF3E0)),
                    _buildCategoryItem('Sports', Icons.electric_car, const Color(0xFFF3E5F5)),
                    _buildCategoryItem('Buses', Icons.directions_bus, const Color(0xFFE8EAF6)),
                  ],
                ),
                const SizedBox(height: 25),
                // Featured Cars Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.stars, color: Colors.orangeAccent),
                        SizedBox(width: 8),
                        Text(
                          'Featured Cars',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Text(
                      'See all',
                      style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Featured Cars List
                SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCarCard('Toyota Camry', '2022 · 25,000 km · Auto', 'EGP 850,000', Icons.directions_car),
                      const SizedBox(width: 15),
                      _buildCarCard('Kia Sportage', '2023 · 10,000 km · Auto', 'EGP 1,200,000', Icons.airport_shuttle),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Showrooms Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.business, color: Colors.blueGrey),
                        SizedBox(width: 8),
                        Text(
                          'Showrooms',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Text(
                      'View all',
                      style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Showrooms List (Dummy)
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
                      ),
                      child: const Icon(Icons.apartment, size: 40, color: Colors.blueGrey),
                    ),
                    const SizedBox(width: 15),
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
                      ),
                      child: const Icon(Icons.apartment, size: 40, color: Colors.blueGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 15), // Space for bottom nav
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.stars, color: Colors.orangeAccent),
                        SizedBox(width: 8),
                        Text(
                          'Maintaince Car',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Text(
                      'See all',
                      style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Featured Cars List
                SizedBox(
                  height: 240,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCarCard('Toyota Camry', '2022 · 25,000 km · Auto', 'EGP 850,000', Icons.directions_car),
                      const SizedBox(width: 15),
                      _buildCarCard('Kia Sportage', '2023 · 10,000 km · Auto', 'EGP 1,200,000', Icons.airport_shuttle),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Stack(
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
                const SizedBox(width: 40), // Space for FAB
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
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color bgColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.blue.shade700),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildCarCard(String name, String details, String price, IconData icon) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD).withOpacity(0.5),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Icon(icon, size: 60, color: Colors.redAccent),
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
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF1A73E8),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
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
        Icon(
          icon,
          color: isSelected ? const Color(0xFF1A73E8) : Colors.grey,
        ),
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
