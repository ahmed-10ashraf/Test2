class CarAd {
  final String id;
  final String titleAr;
  final String titleEn;
  final String detailsAr;
  final String detailsEn;
  final String priceAr;
  final String priceEn;
  final String imagePath;
  final String brandLogo;
  final bool isFeatured;

  CarAd({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.detailsAr,
    required this.detailsEn,
    required this.priceAr,
    required this.priceEn,
    required this.imagePath,
    required this.brandLogo,
    this.isFeatured = false,
  });

  String getTitle(String locale) => locale == 'ar' ? titleAr : titleEn;
  String getDetails(String locale) => locale == 'ar' ? detailsAr : detailsEn;
  String getPrice(String locale) => locale == 'ar' ? priceAr : priceEn;
}
