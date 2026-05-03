import 'package:flutter/material.dart';
import 'package:test2/main.dart';

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
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2); // Start with Showrooms (Arabic RTL usually)
  }

  @override
  void dispose() {
    _tabController.dispose();
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
          backgroundColor: isDark ? Colors.black : const Color(0xFFF5F7FB),
          body: Column(
            children: [
              _buildHeader(context, isAr),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildTabs(isAr, isDark),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildCompaniesList(isAr, isDark),
                          _buildServicesList(isAr, isDark),
                          _buildShowroomsList(isAr, isDark),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isAr) {
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
              const SizedBox(width: 40),
              Text(
                isAr ? 'باقات الاشتراك' : 'Subscription Plans',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ),
              ),
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
                title = isAr ? 'اختار الباقة المناسبة' : 'Choose the right plan';
                subtitle = isAr ? 'وصل معرضك لآلاف المشترين' : 'Reach thousands of buyers';
                icon = Icons.settings_suggest_outlined;
              } else if (_tabController.index == 1) {
                title = isAr ? 'باقات مزودي الخدمات' : 'Service Provider Plans';
                subtitle = isAr ? 'ونش، صيانة، أفلام حماية' : 'Towing, Maintenance, Protection';
                icon = Icons.build_rounded;
              } else {
                title = isAr ? 'باقات الشركات والمؤسسات' : 'Corporate & Institution Plans';
                subtitle = isAr ? 'تأمين، تقسيط، توكيلات رسمية' : 'Insurance, Installment, Agencies';
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

  Widget _buildTabs(bool isAr, bool isDark) {
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
        tabs: [
          Tab(text: isAr ? 'شركات' : 'Companies'),
          Tab(text: isAr ? 'خدمات' : 'Services'),
          Tab(text: isAr ? 'معارض' : 'Showrooms'),
        ],
      ),
    );
  }

  Widget _buildShowroomsList(bool isAr, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'أساسية' : 'Basic',
          subtitle: isAr ? 'للمعارض الصغيرة' : 'For small showrooms',
          price: '500',
          features: [
            PlanFeature(isAr ? 'إعلانات نشطة (10 إعلان)' : '10 Active Ads', true),
            PlanFeature(isAr ? 'ظهور عادي في البحث' : 'Normal Search Appearance', true),
            PlanFeature(isAr ? 'صفحة بروفايل المعرض' : 'Showroom Profile Page', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'معرض موثق' : 'Verified Showroom', false),
            PlanFeature(isAr ? 'إحصائيات الأداء' : 'Performance Analytics', false),
          ],
          buttonText: isAr ? 'ابدأ بالأساسيه' : 'Start Basic',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'احترافية' : 'Professional',
          subtitle: isAr ? 'للمعارض المتوسطة' : 'For medium showrooms',
          price: '1,200',
          isPopular: true,
          badgeText: isAr ? 'الأكثر طلباً ⭐' : 'Most Requested ⭐',
          features: [
            PlanFeature(isAr ? 'إعلانات نشطة (30 إعلان)' : '30 Active Ads', true),
            PlanFeature(isAr ? 'ظهور مميز في البحث' : 'Featured Search Appearance', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'Badge معرض موثق' : 'Verified Badge', true),
            PlanFeature(isAr ? 'إحصائيات ومشاهدات' : 'Analytics & Views', true),
            PlanFeature(isAr ? 'أولوية ظهور في النتائج' : 'Search Priority', false),
          ],
          buttonText: isAr ? 'اشترك دلوقتي' : 'Subscribe Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'بريميوم' : 'Premium',
          subtitle: isAr ? 'للمعارض الكبيرة والتوكيلات' : 'For large showrooms & agencies',
          price: '2,500',
          isPremium: true,
          badgeText: isAr ? '👑 بريميوم' : '👑 Premium',
          features: [
            PlanFeature(isAr ? 'إعلانات نشطة (غير محدودة)' : 'Unlimited Active Ads', true),
            PlanFeature(isAr ? 'أول النتائج دائماً' : 'Always Top of Results', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'Badge معرض ذهبي 👑' : 'Golden Verified Badge 👑', true),
            PlanFeature(isAr ? 'تقرير أداء تفصيلي' : 'Detailed Performance Report', true),
            PlanFeature(isAr ? 'إشعارات للعملاء المهتمين 🔔' : 'Interested Customer Notifications 🔔', true),
          ],
          buttonText: isAr ? 'ترقية للبريميوم' : 'Upgrade to Premium',
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildServicesList(bool isAr, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'أساسية' : 'Basic',
          subtitle: isAr ? 'للخدمات الصغيرة' : 'For small services',
          price: '300',
          features: [
            PlanFeature(isAr ? 'ظهور في قائمة الخدمات' : 'Service List Appearance', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'الموقع على الخريطة' : 'Location on Map', true),
            PlanFeature(isAr ? 'أولوية في نتائج البحث' : 'Search Priority', false),
            PlanFeature(isAr ? 'خدمة موثقة' : 'Verified Service', false),
            PlanFeature(isAr ? 'إحصائيات الزيارات' : 'Visit Analytics', false),
          ],
          buttonText: isAr ? 'ابدأ دلوقتي' : 'Start Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'احترافية' : 'Professional',
          subtitle: isAr ? 'للخدمات المتوسطة' : 'For medium services',
          price: '600',
          isPopular: true,
          badgeText: isAr ? 'الأكثر طلباً ⭐' : 'Most Requested ⭐',
          features: [
            PlanFeature(isAr ? 'ظهور مميز في البحث' : 'Featured Search Appearance', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'الموقع على الخريطة' : 'Location on Map', true),
            PlanFeature(isAr ? 'Badge خدمة موثقة ✓' : 'Verified Badge ✓', true),
            PlanFeature(isAr ? 'إحصائيات الزيارات الشهرية' : 'Monthly Visit Analytics', true),
            PlanFeature(isAr ? 'أولوية قصوى في النتائج' : 'Top Search Priority', false),
          ],
          buttonText: isAr ? 'اشترك دلوقتي' : 'Subscribe Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'بريميوم' : 'Premium',
          subtitle: isAr ? 'للخدمات الكبيرة والسلاسل' : 'For large services & chains',
          price: '1,200',
          isPremium: true,
          badgeText: isAr ? '👑 بريميوم' : '👑 Premium',
          features: [
            PlanFeature(isAr ? 'أول النتائج دائماً' : 'Always Top of Results', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'الموقع على الخريطة' : 'Location on Map', true),
            PlanFeature(isAr ? 'Badge ذهبي موثق 👑' : 'Golden Verified Badge 👑', true),
            PlanFeature(isAr ? 'تقرير أداء تفصيلي' : 'Detailed Performance Report', true),
            PlanFeature(isAr ? 'إشعارات للعملاء القريبين 📍' : 'Nearby Customer Notifications 📍', true),
          ],
          buttonText: isAr ? 'ترقية للبريميوم' : 'Upgrade to Premium',
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildCompaniesList(bool isAr, bool isDark) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      children: [
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'شريك أساسي' : 'Basic Partner',
          subtitle: isAr ? 'للشركات الناشئة' : 'For startups',
          price: '800',
          features: [
            PlanFeature(isAr ? 'ظهور في قسم الشركات' : 'Company Section Appearance', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'صفحة بروفايل الشركة' : 'Company Profile Page', true),
            PlanFeature(isAr ? 'شركة موثقة' : 'Verified Company', false),
            PlanFeature(isAr ? 'أولوية في نتائج البحث' : 'Search Priority', false),
            PlanFeature(isAr ? 'إحصائيات وتقارير' : 'Analytics & Reports', false),
          ],
          buttonText: isAr ? 'ابدأ كشريك' : 'Start as Partner',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'شريك مميز' : 'Premium Partner',
          subtitle: isAr ? 'للشركات المتوسطة' : 'For medium companies',
          price: '1,500',
          isPopular: true,
          badgeText: isAr ? 'الأكثر طلباً ⭐' : 'Most Requested ⭐',
          features: [
            PlanFeature(isAr ? 'ظهور مميز في البحث' : 'Featured Search Appearance', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'شركة موثقة ✓' : 'Verified Company ✓', true),
            PlanFeature(isAr ? 'عروض حصرية للمشتركين' : 'Exclusive Subscriber Offers', true),
            PlanFeature(isAr ? 'إحصائيات شهرية تفصيلية' : 'Detailed Monthly Analytics', true),
            PlanFeature(isAr ? 'إشعارات للعملاء المهتمين' : 'Interested Customer Notifications', false),
          ],
          buttonText: isAr ? 'اشترك دلوقتي' : 'Subscribe Now',
        ),
        const SizedBox(height: 20),
        _buildPlanCard(
          isAr: isAr,
          isDark: isDark,
          title: isAr ? 'شريك ذهبي' : 'Golden Partner',
          subtitle: isAr ? 'للشركات الكبرى والتوكيلات' : 'For major companies & agencies',
          price: '3,000',
          isPremium: true,
          badgeText: isAr ? '👑 ذهبي' : '👑 Gold',
          features: [
            PlanFeature(isAr ? 'أول النتائج دائماً' : 'Always Top of Results', true),
            PlanFeature(isAr ? 'رقم التليفون ظاهر للعملاء' : 'Phone Number Visible', true),
            PlanFeature(isAr ? 'Badge ذهبي رسمي 👑' : 'Official Gold Badge 👑', true),
            PlanFeature(isAr ? 'إشعارات للعملاء المهتمين 🔔' : 'Interested Customer Notifications 🔔', true),
            PlanFeature(isAr ? 'تقرير أداء تفصيلي شهري' : 'Monthly Performance Report', true),
            PlanFeature(isAr ? 'مدير حساب مخصص' : 'Dedicated Account Manager', true),
          ],
          buttonText: isAr ? 'ترقية للذهبي' : 'Upgrade to Gold',
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildPlanCard({
    required bool isAr,
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
                          isAr ? 'جنيه / شهر' : 'EGP / Month',
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

