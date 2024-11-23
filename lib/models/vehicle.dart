class Vehicle {
  final String id;
  final String name;
  final String imageUrl;
  final double pricePerDay;
  final double deposit;
  final String dealerLocation;
  final String timings;
  final bool isOfferAvailable;
  final bool isPayAtPickupAvailable;
  final double rating;
  final String description;
  final String brand;

  Vehicle({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.pricePerDay,
    required this.deposit,
    required this.dealerLocation,
    required this.timings,
    required this.isOfferAvailable,
    required this.isPayAtPickupAvailable,
    required this.rating,
    required this.description,
    required this.brand
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      pricePerDay: json['pricePerDay'],
      deposit: json['deposit'],
      dealerLocation: json['dealerLocation'],
      timings: json['timings'],
      isOfferAvailable: json['isOfferAvailable'],
      isPayAtPickupAvailable: json['isPayAtPickupAvailable'],
      rating: json['rating'],
      description: json['description'],
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'pricePerDay': pricePerDay,
      'deposit': deposit,
      'dealerLocation': dealerLocation,
      'timings': timings,
      'isOfferAvailable': isOfferAvailable,
      'isPayAtPickupAvailable': isPayAtPickupAvailable,
      'rating': rating,
      'description': description,
      'brand': brand,
    };
  }
}
