import '../models/car_ad.dart';

final List<CarAd> featuredCars = [
  CarAd(
    id: '1',
    titleAr: 'هيونداي توسان',
    titleEn: 'Hyundai Tucson',
    detailsAr: '2024 · 0 كم · أوتوماتيك',
    detailsEn: '2024 · 0 km · Auto',
    priceAr: '1,750,000 ج.م',
    priceEn: 'EGP 1,750,000',
    imagePath: 'assets/images/hyundai_tucson_summer_ad_v2.png',
    brandLogo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Hyundai_Motor_Company_logo.svg/1024px-Hyundai_Motor_Company_logo.svg.png',
    isFeatured: true,
  ),
  CarAd(
    id: '2',
    titleAr: 'أودي A6 سيدان',
    titleEn: 'Audi A6 Sedan',
    detailsAr: '2023 · 0 كم · أوتوماتيك',
    detailsEn: '2023 · 0 km · Auto',
    priceAr: '3,850,000 ج.م',
    priceEn: 'EGP 3,850,000',
    imagePath: 'https://images.unsplash.com/photo-1541348263662-e0c8de4259ba?auto=format&fit=crop&q=80&w=400',
    brandLogo: 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Audi-Logo_2016.svg/1024px-Audi-Logo_2016.svg.png',
    isFeatured: true,
  ),
  CarAd(
    id: '3',
    titleAr: 'بورشه 911 GT3',
    titleEn: 'Porsche 911 GT3',
    detailsAr: '2024 · 0 كم · PDK',
    detailsEn: '2024 · 0 km · PDK',
    priceAr: '12,500,000 ج.م',
    priceEn: 'EGP 12,500,000',
    imagePath: 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&q=80&w=400',
    brandLogo: 'https://upload.wikimedia.org/wikipedia/en/thumb/d/d9/Porsche_logo.svg/800px-Porsche_logo.svg.png',
    isFeatured: true,
  ),
];

final List<Map<String, String>> bannersEn = [
  {
    'title': 'Summer Offer from Hyundai',
    'subtitle': 'The strongest summer offers in Egypt',
    'image': 'assets/images/hyundai_tucson_summer_ad_v2.png',
    'cta': 'Learn More'
  },
  {
    'title': 'Find Your Dream Car',
    'subtitle': 'Up to 30% Off Listings',
    'image': 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=800',
    'cta': 'Browse Deals'
  },
];

final List<Map<String, String>> bannersAr = [
  {
    'title': 'عرض الصيف من هيونداي',
    'subtitle': 'أقوى عروض الصيف في مصر',
    'image': 'assets/images/hyundai_tucson_summer_ad_v2.png',
    'cta': 'لمعرفة المزيد'
  },
  {
    'title': 'اعثر على سيارة أحلامك',
    'subtitle': 'خصومات تصل إلى 30% على الإدراجات',
    'image': 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&q=80&w=800',
    'cta': 'تصفح العروض'
  },
];
