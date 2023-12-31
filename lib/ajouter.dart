// activity_model.dart

class Activite {
  String title;
  String location;
  double price;
  int numberOfPeople;
  String imageUrl;
  String imageCategory;

  Activite({
    required this.title,
    required this.location,
    required this.price,
    required this.numberOfPeople,
    required this.imageUrl,
    required this.imageCategory,
  });
}
