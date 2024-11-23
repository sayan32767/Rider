import 'package:flutter/material.dart';
import 'package:rider/components/vehicle_card.dart';
import 'package:rider/models/vehicle.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Vehicle> vehicles = [
    Vehicle(
      id: "1",
      name: "Royal Enfield Meteor 350",
      imageUrl:
          "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
      pricePerDay: 1000.0,
      deposit: 5000.0,
      dealerLocation: "Beliaghata",
      timings: "9:00 AM - 8:00 PM",
      isOfferAvailable: true,
      isPayAtPickupAvailable: true,
      rating: 4.5,
      description: 'If you are looking for a stylish bike that does not compromise on great features...'
    ),
    Vehicle(
      id: "2",
      name: "Honda Activa 6G",
      imageUrl:
          "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
      pricePerDay: 500.0,
      deposit: 2000.0,
      dealerLocation: "Salt Lake",
      timings: "8:00 AM - 10:00 PM",
      isOfferAvailable: false,
      isPayAtPickupAvailable: true,
      rating: 4.3,
      description: 'If you are looking for a stylish bike that does not compromise on great features...'
    ),
    Vehicle(
      id: "2",
      name: "Honda Activa 6G",
      imageUrl:
          "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
      pricePerDay: 500.0,
      deposit: 2000.0,
      dealerLocation: "Salt Lake",
      timings: "8:00 AM - 10:00 PM",
      isOfferAvailable: false,
      isPayAtPickupAvailable: true,
      rating: 4.3,
      description: 'If you are looking for a stylish bike that does not compromise on great features...'
    ),
    Vehicle(
      id: "2",
      name: "Honda Activa 6G",
      imageUrl:
          "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
      pricePerDay: 500.0,
      deposit: 2000.0,
      dealerLocation: "Salt Lake",
      timings: "8:00 AM - 10:00 PM",
      isOfferAvailable: false,
      isPayAtPickupAvailable: true,
      rating: 4.3,
      description: 'If you are looking for a stylish bike that does not compromise on great features...'
    ),
    Vehicle(
      id: "2",
      name: "Honda Activa 6G",
      imageUrl:
          "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
      pricePerDay: 500.0,
      deposit: 2000.0,
      dealerLocation: "Salt Lake",
      timings: "8:00 AM - 10:00 PM",
      isOfferAvailable: false,
      isPayAtPickupAvailable: true,
      rating: 4.3,
      description: 'If you are looking for a stylish bike that does not compromise on great features...'
    ),
    Vehicle(
      id: "2",
      name: "Honda Activa 6G",
      imageUrl:
          "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
      pricePerDay: 500.0,
      deposit: 2000.0,
      dealerLocation: "Salt Lake",
      timings: "8:00 AM - 10:00 PM",
      isOfferAvailable: false,
      isPayAtPickupAvailable: true,
      rating: 4.3,
      description: 'If you are looking for a stylish bike that does not compromise on great features...'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: vehicles.length,
          itemBuilder: (context, index) {
            return VehicleCard(vehicle: vehicles[index]);
          },
        ),
      ),
    );
  }
}
