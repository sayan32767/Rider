import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rider/components/vehicle_card.dart';
import 'package:rider/models/vehicle.dart';
import 'package:rider/screens/home/locations_screen.dart';
import 'package:rider/screens/home/notifications_screen.dart';
import 'package:rider/screens/home/search_screen.dart';
import 'package:rider/services/navigation_services.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Map<String, String>> carousel = [
  {
    'name': 'Grocery & Gourmet Food',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8MpOELSWyeP_wrEF8-MuNpz2BE7lPLBqWsw&s'
  },
  {
    'name': 'Health & Household',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4Kgb0vfeGzM8xOkMdyrOhHLaxkomKUYz8Yw&s'
  },
  {
    'name': 'Clothing, Shoes & Jewelry',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBRXtf0GnNBgW7pOOjNAaGRXXPriOax1UzDw&s'
  },
  {
    'name': 'Home & Kitchen',
    'imageUrl':
        'https://assets.architecturaldigest.in/photos/63cfc0821283a95e1e2c885f/4:3/w_1440,h_1080,c_limit/8%20kitchen%20gadgets%20to%20upgrade%20your%20cooking%20in%202023.jpg'
  },
  {
    'name': 'Electronics',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_E66CzMaeDrENvrTRQrcQtYKFD2mmAL-_Hw&s'
  },
  {
    'name': 'Other',
    'imageUrl':
        'https://marketplace.canva.com/EAE54xVnIvo/1/0/1600w/canva-beige-green-simple-product-feature-instagram-posts-4DHnplrmIp0.jpg'
  },
];

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _pickupDate;
  TimeOfDay? _pickupTime;
  DateTime? _dropoffDate;
  TimeOfDay? _dropoffTime;

  // Function to pick a date
  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          _pickupDate = picked;
        } else {
          _dropoffDate = picked;
        }
      });
    }
  }

  // Function to pick a time
  Future<void> _selectTime(BuildContext context, bool isPickup) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isPickup) {
          _pickupTime = picked;
        } else {
          _dropoffTime = picked;
        }
      });
    }
  }

  String location = "Select Location";

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        toolbarHeight: 75.0,
        backgroundColor: AppColors.primary,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'It All Starts Here!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context)
                        .push(SlidePageRoute(page: LocationsScreen())).then((value) {
                          setState(() {
                            location = value;
                          });
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        location,
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 18,
                      )
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context)
                .push(SlidePageRoute(page: SearchScreen()));
              },
              child: Icon(
                MingCute.search_3_line
              ),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context)
                .push(SlidePageRoute(page: NotificationsScreen()));
              },
              child: Icon(
                MingCute.notification_line
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    [
                      'https://i.pinimg.com/736x/27/f8/3a/27f83a1a4952e167b728d00e2a3f0e30.jpg',
                      'Bike'
                    ],
                    [
                      'https://cdn.olaelectric.com/sites/evdp/pages/boss/home_banner_season_sale_mweb_v7.webp',
                      'Scooty'
                    ],
                  ].map((vehicle) {
                    return InkWell(
                      splashFactory: null,
                      splashColor: Colors.transparent,
                      onTap: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width * 0.35,
                        margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            image: DecorationImage(
                              image: NetworkImage(
                                vehicle[0],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    vehicle[1],
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(16.0),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.lightBackground.withOpacity(0.1),
                      AppColors.darkBackground.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft, // Gradient starts here
                    end: Alignment.bottomRight, // Gradient ends here
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book your next ride',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Pick Up',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _pickupDate != null
                                      ? '${_pickupDate!.day}/${_pickupDate!.month}/${_pickupDate!.year}'
                                      : 'Select Date',
                                  prefixIcon: Icon(MingCute.calendar_3_line),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Adjust the radius for roundness
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color
                                      width:
                                          1.0, // Optional: customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color for enabled state
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Optional: customize border color for focused state
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectTime(context, true),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _pickupTime != null
                                      ? _pickupTime!.format(context)
                                      : 'Select Time',
                                  prefixIcon: Icon(MingCute.time_line),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Adjust the radius for roundness
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color
                                      width:
                                          1.0, // Optional: customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color for enabled state
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Optional: customize border color for focused state
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Drop Off',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _dropoffDate != null
                                      ? '${_dropoffDate!.day}/${_dropoffDate!.month}/${_dropoffDate!.year}'
                                      : 'Select Date',
                                  prefixIcon: Icon(MingCute.calendar_3_line),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Adjust the radius for roundness
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color
                                      width:
                                          1.0, // Optional: customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color for enabled state
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Optional: customize border color for focused state
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectTime(context, false),
                            child: AbsorbPointer(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _dropoffTime != null
                                      ? _dropoffTime!.format(context)
                                      : 'Select Time',
                                  prefixIcon: Icon(MingCute.time_line),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Adjust the radius for roundness
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color
                                      width:
                                          1.0, // Optional: customize border width
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Optional: customize border color for enabled state
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Same radius as above
                                    borderSide: BorderSide(
                                      color: Colors
                                          .blue, // Optional: customize border color for focused state
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.0),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle search logic
                          print(
                              "Pickup: ${_pickupDate?.toLocal()} at ${_pickupTime?.format(context)}");
                          print(
                              "Dropoff: ${_dropoffDate?.toLocal()} at ${_dropoffTime?.format(context)}");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 255, 210, 32), // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ), // Reduce radius for less roundness
                          ),
                        ),
                        child: Text(
                          'SEARCH',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: VehicleCard(
                        vehicle: Vehicle(
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
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.7,
                      child: VehicleCard(
                        vehicle: Vehicle(
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
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
