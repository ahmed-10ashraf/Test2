import 'package:flutter/material.dart';
import 'package:test2/main.dart';
import 'new_cars_screen.dart';

class ServicesListScreen extends StatelessWidget {
  const ServicesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text('Services & Showrooms'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDark ? Colors.black : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCategoryGroup(
            isDark: isDark,
            title: 'Car Showrooms',
            icon: Icons.inventory_2_outlined,
            iconColor: const Color(0xFF1565C0),
            badgeText: '+3K',
            badgeColor: const Color(0xFFE3F2FD),
            items: [
              _buildServiceItem(
                isDark: isDark,
                title: 'New Cars',
                icon: Icons.add,
                iconColor: const Color(0xFFE8F5E9),
                iconWidgetColor: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewCarsScreen()),
                  );
                },
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Used Cars',
                icon: Icons.access_time,
                iconColor: const Color(0xFFFFF8E1),
                iconWidgetColor: Colors.orange[800],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewCarsScreen()),
                  );
                },
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Verified Showrooms',
                icon: Icons.verified_user_outlined,
                iconColor: const Color(0xFFE3F2FD),
                iconWidgetColor: const Color(0xFF1565C0),
                leftBadge: 'Verified',
                leftBadgeColor: const Color(0xFFE3F2FD),
                leftBadgeTextColor: const Color(0xFF1565C0),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCategoryGroup(
            isDark: isDark,
            title: 'Companies & Suppliers',
            icon: Icons.home_work_outlined,
            iconColor: const Color(0xFF00897B),
            badgeText: '+8K',
            badgeColor: const Color(0xFFE0F2F1),
            items: [
              _buildServiceItem(
                isDark: isDark,
                title: 'Spare Parts Companies',
                icon: Icons.directions_car_outlined,
                iconColor: const Color(0xFFFFF3E0),
                iconWidgetColor: Colors.orange[900],
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Insurance Companies',
                icon: Icons.verified_user_outlined,
                iconColor: const Color(0xFFE3F2FD),
                iconWidgetColor: const Color(0xFF1565C0),
                leftBadge: 'New',
                leftBadgeColor: const Color(0xFFFFF8E1),
                leftBadgeTextColor: Colors.orange[800]!,
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Protection Film Companies',
                icon: Icons.grid_on_outlined,
                iconColor: const Color(0xFFE8EAF6),
                iconWidgetColor: Colors.indigo,
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Accessories Companies',
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFFFCE4EC),
                iconWidgetColor: Colors.pink,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCategoryGroup(
            isDark: isDark,
            title: 'Services',
            icon: Icons.build_outlined,
            iconColor: Colors.orange[800]!,
            leftBadge: 'New',
            leftBadgeColor: const Color(0xFFFFF8E1),
            leftBadgeTextColor: Colors.orange[800]!,
            items: [
              _buildServiceItem(
                isDark: isDark,
                title: 'Maintenance Services',
                icon: Icons.build_outlined,
                iconColor: const Color(0xFFE3F2FD),
                iconWidgetColor: const Color(0xFF1565C0),
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Car Towing Services',
                icon: Icons.directions_car_filled_outlined,
                iconColor: const Color(0xFFFCE4EC),
                iconWidgetColor: Colors.red[900],
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildCategoryGroup(
            isDark: isDark,
            title: 'Financing & Evaluation',
            icon: Icons.credit_card_outlined,
            iconColor: Colors.deepPurple,
            items: [
              _buildServiceItem(
                isDark: isDark,
                title: 'New Car Financing',
                icon: Icons.attach_money,
                iconColor: const Color(0xFFE3F2FD),
                iconWidgetColor: const Color(0xFF1565C0),
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Used Car Financing',
                icon: Icons.monetization_on_outlined,
                iconColor: const Color(0xFFFFF8E1),
                iconWidgetColor: Colors.orange[800],
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Evaluate Your Car',
                icon: Icons.assignment_turned_in_outlined,
                iconColor: const Color(0xFFE8F5E9),
                iconWidgetColor: Colors.green,
                leftBadge: 'Free',
                leftBadgeColor: const Color(0xFFE8F5E9),
                leftBadgeTextColor: Colors.green[800]!,
              ),
              _buildServiceItem(
                isDark: isDark,
                title: 'Car Comparison',
                icon: Icons.compare_arrows_rounded,
                iconColor: const Color(0xFFE8EAF6),
                iconWidgetColor: Colors.indigo,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSimpleItem(
            isDark: isDark,
            title: 'Technical Center',
            icon: Icons.build_circle_outlined,
            iconColor: isDark ? Colors.white10 : const Color(0xFFF0F2F5),
            iconWidgetColor: isDark ? Colors.white70 : Colors.black54,
          ),
          const SizedBox(height: 12),
          _buildSimpleItem(
            isDark: isDark,
            title: 'Help & Support',
            icon: Icons.headset_mic_outlined,
            iconColor: isDark ? Colors.white10 : const Color(0xFFF0F2F5),
            iconWidgetColor: isDark ? Colors.white70 : Colors.black54,
          ),
          const SizedBox(height: 12),
          _buildSimpleItem(
            isDark: isDark,
            title: 'Terms & Conditions',
            icon: Icons.description_outlined,
            iconColor: isDark ? Colors.white10 : const Color(0xFFF0F2F5),
            iconWidgetColor: isDark ? Colors.white70 : Colors.black54,
          ),
          const SizedBox(height: 12),
          _buildSimpleItem(
            isDark: isDark,
            title: 'Privacy Policy',
            icon: Icons.shield_outlined,
            iconColor: isDark ? Colors.white10 : const Color(0xFFF0F2F5),
            iconWidgetColor: isDark ? Colors.white70 : Colors.black54,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCategoryGroup({
    required bool isDark,
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> items,
    String? badgeText,
    Color? badgeColor,
    String? leftBadge,
    Color? leftBadgeColor,
    Color? leftBadgeTextColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (badgeText != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: badgeColor ?? const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeText,
                      style: const TextStyle(color: Color(0xFF1565C0), fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                if (leftBadge != null)
                   Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: leftBadgeColor ?? const Color(0xFFFFF8E1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      leftBadge,
                      style: TextStyle(color: leftBadgeTextColor ?? Colors.orange[800], fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ),
                const Spacer(),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: iconColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
          const Divider(height: 1, indent: 15, endIndent: 15),
          ...items,
        ],
      ),
    );
  }

  Widget _buildServiceItem({
    required bool isDark,
    required String title,
    required IconData icon,
    required Color iconColor,
    Color? iconWidgetColor,
    String? leftBadge,
    Color? leftBadgeColor,
    Color? leftBadgeTextColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        child: Row(
          children: [
            Icon(Icons.chevron_left, color: Colors.grey[300], size: 20),
            const SizedBox(width: 10),
            if (leftBadge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: leftBadgeColor ?? const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  leftBadge,
                  style: TextStyle(
                    color: leftBadgeTextColor ?? const Color(0xFF1565C0),
                    fontSize: 11, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const Spacer(),
            Text(
              title,
              style: TextStyle(
                fontSize: 15, 
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconWidgetColor ?? Colors.blue[700], size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleItem({
    required bool isDark,
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color iconWidgetColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: [
              Icon(Icons.chevron_left, color: Colors.grey[300], size: 20),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF2D3142),
                ),
              ),
              const SizedBox(width: 15),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconWidgetColor, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

