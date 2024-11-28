import 'package:rider/models/location.dart';

class Vehicle {
  final String id;
  final String name;
  final String brand;
  final double price;
  final int buyingYear;
  final String description;
  final String imageUrl;
  final String fuelType;
  final double mileage;
  final String vehicleType;
  final String sellerId;
  final Location? location;
  final bool? isAvailable;

  Vehicle({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.buyingYear,
    required this.description,
    required this.imageUrl,
    required this.fuelType,
    required this.mileage,
    required this.vehicleType,
    required this.sellerId,
    this.location,
    this.isAvailable,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'price': price,
      'buyingYear': buyingYear,
      'description': description,
      'imageUrl': imageUrl,
      'fuelType': fuelType,
      'mileage': mileage,
      'vehicleType': vehicleType,
      'sellerId': sellerId,
      'location': location?.toJson(),
      'isAvailable': isAvailable ?? false
    };
  }

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      price: json['price'],
      buyingYear: json['buyingYear'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      fuelType: json['fuelType'],
      mileage: json['mileage'],
      vehicleType: json['vehicleType'],
      sellerId: json['sellerId'],
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
      isAvailable: json['isAvailable'] ?? false
    );
  }
}
