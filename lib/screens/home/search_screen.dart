import 'package:flutter/material.dart';
import 'package:rider/components/text_field.dart';
import 'package:rider/components/text_field_alt.dart';
import 'package:rider/components/vehicle_card.dart';
import 'package:rider/models/vehicle.dart';
import 'package:rider/screens/home/filter_screen.dart';
import 'package:rider/screens/home/locations_screen.dart';
import 'package:rider/services/navigation_services.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Vehicle> vehicles = [
    Vehicle(
        id: "1",
        name: "Royal Enfield Meteor 350",
        brand: "Royal Enfield",
        imageUrl:
            "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
        pricePerDay: 1000.0,
        deposit: 5000.0,
        dealerLocation: "Beliaghata",
        timings: "9:00 AM - 8:00 PM",
        isOfferAvailable: true,
        isPayAtPickupAvailable: true,
        rating: 4.5,
        description:
            'If you are looking for a stylish bike that does not compromise on great features...'),
    Vehicle(
        id: "2",
        name: "Honda Activa 6G",
        brand: "HERO",
        imageUrl:
            "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
        pricePerDay: 500.0,
        deposit: 2000.0,
        dealerLocation: "Salt Lake",
        timings: "8:00 AM - 10:00 PM",
        isOfferAvailable: false,
        isPayAtPickupAvailable: true,
        rating: 4.3,
        description:
            'If you are looking for a stylish bike that does not compromise on great features...'),
    Vehicle(
        id: "2",
        name: "Honda Activa 6G",
        brand: "HERO",
        imageUrl:
            "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
        pricePerDay: 500.0,
        deposit: 2000.0,
        dealerLocation: "Salt Lake",
        timings: "8:00 AM - 10:00 PM",
        isOfferAvailable: false,
        isPayAtPickupAvailable: true,
        rating: 4.3,
        description:
            'If you are looking for a stylish bike that does not compromise on great features...'),
    Vehicle(
        id: "2",
        name: "Honda Activa 6G",
        brand: "HERO",
        imageUrl:
            "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
        pricePerDay: 500.0,
        deposit: 2000.0,
        dealerLocation: "Salt Lake",
        timings: "8:00 AM - 10:00 PM",
        isOfferAvailable: false,
        isPayAtPickupAvailable: true,
        rating: 4.3,
        description:
            'If you are looking for a stylish bike that does not compromise on great features...'),
    Vehicle(
        id: "2",
        name: "Honda Activa 6G",
        brand: "HERO",
        imageUrl:
            "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
        pricePerDay: 500.0,
        deposit: 2000.0,
        dealerLocation: "Salt Lake",
        timings: "8:00 AM - 10:00 PM",
        isOfferAvailable: false,
        isPayAtPickupAvailable: true,
        rating: 4.3,
        description:
            'If you are looking for a stylish bike that does not compromise on great features...'),
    Vehicle(
        id: "2",
        name: "Honda Activa 6G",
        brand: "HERO",
        imageUrl:
            "https://www.rentrip.in/uploads/products/bike/370x220/225064IMG_1550325631.webp",
        pricePerDay: 500.0,
        deposit: 2000.0,
        dealerLocation: "Salt Lake",
        timings: "8:00 AM - 10:00 PM",
        isOfferAvailable: false,
        isPayAtPickupAvailable: true,
        rating: 4.3,
        description:
            'If you are looking for a stylish bike that does not compromise on great features...'),
  ];

  String searchText = "";

  final TextEditingController _searchController = TextEditingController();

  search(String value) {
    setState(() {
      searchText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Column(
        children: [
          SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: MyTextformfield(
                controller: _searchController,
                onChanged: (value) {
                  search(value);
                },
                hintText: 'Search for a vehicle',
                trailing: SizedBox(
                  width: 20,
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_alt,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      print("Filter icon pressed");
                      Navigator.of(context)
                        .push(SlidePageRoute(page: FilterScreen()));
                    },
                  ),
                )),
          ),
          searchText.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      return VehicleCard(vehicle: vehicles[index]);
                    },
                  ),
                )
              : Expanded(
                  child: Center(
                    // Center the content
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, // Minimize the vertical space occupied
                      mainAxisAlignment:
                          MainAxisAlignment.center, // Center vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center horizontally
                      children: [
                        SizedBox(
                          width: 200,
                          child: Image.asset('assets/scooter2.png'),
                        ),
                      
                        Transform.translate(
                          offset: Offset(0, -20),
                          child: Text(
                            'Vehicles are just one search away',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
