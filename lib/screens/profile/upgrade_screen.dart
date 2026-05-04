import 'package:flutter/material.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  State<UpgradeScreen> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF5F7FB),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTabs(isDark),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildCompaniesList(isDark),
                      _buildServicesList(isDark),
                      _buildShowroomsList(isDark),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 20, right: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                ),
              ),
              const Text(
                'Subscription Plans',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
          const SizedBox(height: 25),
          AnimatedBuilder(
            animation: _tabController,
            builder: (context, child) {
              String title = '';
              String subtitle = '';
              IconData icon = Icons.settings;

              if (_tabController.index == 2) {
                title = 'Choose the right plan';
                subtitle = 'Reach thousands of buyers';
                icon = Icons.settings_suggest_outlined;
              } else if (_tabController.index == 1) {
                title = 'Service Provider Plans';
                subtitle = 'Towing, Maintenance, Protection';
                icon = Icons.build_rounded;
              } else {
                title = 'Corporate & Institution Plans';
                subtitle = 'Insurance, Installment, Agencies';
                icon = Icons.business_rounded;
              }

              return Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
        ],
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF1565C0),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: isDark ? Colors.white70 : Colors.grey,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'Companies'),
          Tab(text: 'Services'),
          Tab(text: 'Showrooms'),
        ],
      ),
    );
  }

  Widget _buildShowroomsList(bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        _buildPlanCard(
          isDark: isDark,
          title: 'Basic',
          subtitle: 'For small showrooms',
          price: '500',
          features: [
            PlanFeature('10 Active Ads', true),
            PlanFeature('Normal Search Appearance', true),
            PlanFeature('Showroom Profile Page', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Verified Showroom', false),
            PlanFeature('Performance Analytics', false),
          ],
          buttonText: 'Start Basic',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isDark: isDark,
          title: 'Professional',
          subtitle: 'For medium showrooms',
          price: '1,200',
          isPopular: true,
          badgeText: 'Most Requested ⭐',
          features: [
            PlanFeature('30 Active Ads', true),
            PlanFeature('Featured Search Appearance', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Verified Badge', true),
            PlanFeature('Analytics & Views', true),
            PlanFeature('Search Priority', false),
          ],
          buttonText: 'Subscribe Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isDark: isDark,
          title: 'Premium',
          subtitle: 'For large showrooms & agencies',
          price: '2,500',
          isPremium: true,
          badgeText: '👑 Premium',
          features: [
            PlanFeature('Unlimited Active Ads', true),
            PlanFeature('Always Top of Results', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Golden Verified Badge 👑', true),
            PlanFeature('Detailed Performance Report', true),
            PlanFeature('Interested Customer Notifications 🔔', true),
          ],
          buttonText: 'Upgrade to Premium',
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildServicesList(bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        _buildPlanCard(
          isDark: isDark,
          title: 'Basic',
          subtitle: 'For small services',
          price: '300',
          features: [
            PlanFeature('Service List Appearance', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Location on Map', true),
            PlanFeature('Search Priority', false),
            PlanFeature('Verified Service', false),
            PlanFeature('Visit Analytics', false),
          ],
          buttonText: 'Start Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isDark: isDark,
          title: 'Professional',
          subtitle: 'For medium services',
          price: '600',
          isPopular: true,
          badgeText: 'Most Requested ⭐',
          features: [
            PlanFeature('Featured Search Appearance', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Location on Map', true),
            PlanFeature('Verified Badge ✓', true),
            PlanFeature('Monthly Visit Analytics', true),
            PlanFeature('Top Search Priority', false),
          ],
          buttonText: 'Subscribe Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isDark: isDark,
          title: 'Premium',
          subtitle: 'For large services & chains',
          price: '1,200',
          isPremium: true,
          badgeText: '👑 Premium',
          features: [
            PlanFeature('Always Top of Results', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Location on Map', true),
            PlanFeature('Golden Verified Badge 👑', true),
            PlanFeature('Detailed Performance Report', true),
            PlanFeature('Nearby Customer Notifications 📍', true),
          ],
          buttonText: 'Upgrade to Premium',
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildCompaniesList(bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        _buildPlanCard(
          isDark: isDark,
          title: 'Basic Partner',
          subtitle: 'For startups',
          price: '800',
          features: [
            PlanFeature('Company Section Appearance', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Company Profile Page', true),
            PlanFeature('Verified Company', false),
            PlanFeature('Search Priority', false),
            PlanFeature('Analytics & Reports', false),
          ],
          buttonText: 'Start as Partner',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isDark: isDark,
          title: 'Premium Partner',
          subtitle: 'For medium companies',
          price: '1,500',
          isPopular: true,
          badgeText: 'Most Requested ⭐',
          features: [
            PlanFeature('Featured Search Appearance', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Verified Company ✓', true),
            PlanFeature('Exclusive Subscriber Offers', true),
            PlanFeature('Detailed Monthly Analytics', true),
            PlanFeature('Interested Customer Notifications', false),
          ],
          buttonText: 'Subscribe Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isDark: isDark,
          title: 'Golden Partner',
          subtitle: 'For major companies & agencies',
          price: '3,000',
          isPremium: true,
          badgeText: '👑 Gold',
          features: [
            PlanFeature('Always Top of Results', true),
            PlanFeature('Phone Number Visible', true),
            PlanFeature('Official Gold Badge 👑', true),
            PlanFeature('Interested Customer Notifications 🔔', true),
            PlanFeature('Monthly Performance Report', true),
            PlanFeature('Dedicated Account Manager', true),
          ],
          buttonText: 'Upgrade to Gold',
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildPlanCard({
    required bool isDark,
    required String title,
    required String subtitle,
    required String price,
    required List<PlanFeature> features,
    required String buttonText,
    bool isPopular = false,
    bool isPremium = false,
    String? badgeText,
  }) {
    Color borderColor = Colors.transparent;
    Color buttonColor = const Color(0xFF1565C0);
    Color badgeColor = Colors.orange;

    if (isPopular) {
      borderColor = const Color(0xFF1565C0);
      badgeColor = const Color(0xFF0D47A1);
    } else if (isPremium) {
      borderColor = Colors.orange.withValues(alpha: 0.5);
      buttonColor = Colors.orange;
      badgeColor = Colors.orange;
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (badgeText != null)
            PositionedDirectional(
              top: -12,
              start: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'EGP / Month',
                          style: TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                ...features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            feature.isActive ? Icons.check_circle : Icons.cancel,
                            color: feature.isActive ? const Color(0xFF4CAF50) : Colors.grey[300],
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature.text,
                              style: TextStyle(
                                fontSize: 14,
                                color: feature.isActive ? (isDark ? Colors.white : Colors.black87) : Colors.grey[400],
                                decoration: feature.isActive ? null : TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                          if (feature.isActive && feature.text.contains('('))
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE3F2FD),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                feature.text.split('(')[1].replaceAll(')', ''),
                                style: const TextStyle(color: Color(0xFF1565C0), fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                        ],
                      ),
                    )),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isPopular && !isPremium 
                        ? (isDark ? Colors.transparent : Colors.white)
                        : (isPopular ? const Color(0xFF1565C0) : buttonColor),
                      foregroundColor: !isPopular && !isPremium 
                        ? const Color(0xFF1565C0) 
                        : Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: !isPopular && !isPremium 
                          ? BorderSide(color: const Color(0xFF1565C0).withValues(alpha: 0.5))
                          : BorderSide.none,
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlanFeature {
  final String text;
  final bool isActive;

  PlanFeature(this.text, this.isActive);
}

