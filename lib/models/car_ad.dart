class CarAd {
  final String id;
  final String titleEn;
  final String titleAr;
  final String detailsEn;
  final String detailsAr;
  final String priceEn;
  final String priceAr;
  final String imagePath;
  final String brandLogo;
  final bool isFeatured;

  CarAd({
    required this.id,
    required this.titleEn,
    required this.titleAr,
    required this.detailsEn,
    required this.detailsAr,
    required this.priceEn,
    required this.priceAr,
    required this.imagePath,
    required this.brandLogo,
    this.isFeatured = false,
  });
}
