import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:rider/components/vehicle_card.dart';
import 'package:rider/models/vehicle.dart';
import 'package:rider/providers/user_provider.dart';
import 'package:rider/screens/home/locations_screen.dart';
import 'package:rider/screens/home/notifications_screen.dart';
import 'package:rider/screens/home/search_screen.dart';
import 'package:rider/screens/home/vehicle_details_page.dart';
import 'package:rider/services/navigation_services.dart';
import 'package:rider/services/vehicle_service.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getLocation().then((value) {
      if (mounted) {
        setState(() {
          location = value;
          _isLoading = false;
        });
      }
    });
  }

  Future<String> getLocation() async {
    setState(() {
      _isLoading = true;
    });
    return _vehicleService.getLocation();
  }

  final VehicleService _vehicleService = VehicleService();

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? GradientScaffold(
            body:
                Center(child: CircularProgressIndicator(color: Colors.yellow)))
        : GradientScaffold(
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.of(context)
                              .push(SlidePageRoute(page: LocationsScreen()))
                              .then((value) async {
                            await _vehicleService
                                .updateLocation(value ?? location ?? '');
                            setState(() {
                              location = value ?? location ?? '';
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              location.isEmpty ? 'Select Location' : location,
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
                  
                  // SizedBox(
                  //   width: 20,
                  // ),
                  // InkWell(
                  //   splashColor: Colors.transparent,
                  //   onTap: () {
                  //     Navigator.of(context)
                  //         .push(SlidePageRoute(page: NotificationsScreen()));
                  //   },
                  //   child: Icon(MingCute.notification_line),
                  // ),
                ],
              ),
            ),
            body: location.isEmpty
                ? Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(SlidePageRoute(page: LocationsScreen()))
                            .then((value) async {
                          await _vehicleService
                              .updateLocation(value ?? location ?? '');
                          setState(() {
                            location = value ?? location ?? '';
                          });
                        });
                      },
                      child: Expanded(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Image.asset('assets/location.png'),
                              ),
                              Transform.translate(
                                offset: Offset(0, 10),
                                child: Text(
                                  'Please Select a Location to Continue',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Column(
                        children: [
                          // SizedBox(height: 18),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 12),
                          //   child: SizedBox(
                          //     height: 220,
                          //     child: SingleChildScrollView(
                          //       scrollDirection: Axis.horizontal,
                          //       child: Row(
                          //         children: [
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.only(right: 16.0),
                          //             child: Container(
                          //               width:
                          //                   MediaQuery.sizeOf(context).width *
                          //                       0.7,
                          //               height: 200,
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(16.0),
                          //                 image: const DecorationImage(
                          //                   image: AssetImage(
                          //                       'assets/banner.png'), // Replace with your image path
                          //                   fit: BoxFit.cover,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.only(right: 16.0),
                          //             child: Container(
                          //               width:
                          //                   MediaQuery.sizeOf(context).width *
                          //                       0.7,
                          //               height: 200,
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(16.0),
                          //                 image: const DecorationImage(
                          //                   image:
                          //                       AssetImage('assets/banner.png'),
                          //                   fit: BoxFit.cover,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //           Padding(
                          //             padding:
                          //                 const EdgeInsets.only(right: 16.0),
                          //             child: Container(
                          //               width:
                          //                   MediaQuery.sizeOf(context).width *
                          //                       0.7,
                          //               height: 200,
                          //               decoration: BoxDecoration(
                          //                 borderRadius:
                          //                     BorderRadius.circular(16.0),
                          //                 image: const DecorationImage(
                          //                   image:
                          //                       AssetImage('assets/banner.png'),
                          //                   fit: BoxFit.cover,
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //        ],
                          //      ),
                          //    ),
                          //  ),
                          //),
                          SizedBox(height: 20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Container(
                              // padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(16.0),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.lightBackground.withOpacity(0.1),
                                    AppColors.darkBackground.withOpacity(0.7),
                                  ],
                                  begin:
                                      Alignment.topLeft, // Gradient starts here
                                  end: Alignment
                                      .bottomRight, // Gradient ends here
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Book your next ride',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                                  // SizedBox(height: 15.0),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        // Book a Bike Section
                                        ListTile(
                                          leading: Icon(Icons.directions_bike,
                                              color:
                                                  Colors.yellow), // Bike Icon
                                          title: Text('Book a Bike'),
                                          trailing: Icon(Icons.arrow_forward,
                                              color: Colors
                                                  .yellow), // Right Chevron Icon
                                          onTap: () {
                                            // Handle the tap for booking a bike
                                            print('Tapped on Book a Bike');
                                          },
                                        ),
                                        Divider(), // Optional divider between sections

                                        // Book a Scooter Section
                                        ListTile(
                                          leading: Icon(Icons.two_wheeler,
                                              color: Colors
                                                  .yellow), // Scooter Icon
                                          title: Text('Book a Scooter'),
                                          trailing: Icon(Icons.arrow_forward,
                                              color: Colors
                                                  .yellow), // Right Chevron Icon
                                          onTap: () {
                                            // Handle the tap for booking a scooter
                                            print('Tapped on Book a Scooter');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 12),

                                  // Padding(
                                  //   padding: EdgeInsets.all(16.0),
                                  //   child: SizedBox(
                                  //     height: 50,
                                  //     width: double.infinity,
                                  //     child: ElevatedButton(
                                  //       onPressed: () {},
                                  //       style: ElevatedButton.styleFrom(
                                  //         backgroundColor: const Color.fromARGB(
                                  //             255,
                                  //             255,
                                  //             210,
                                  //             32), // Button color
                                  //         shape: RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.circular(
                                  //             12.0,
                                  //           ), // Reduce radius for less roundness
                                  //         ),
                                  //       ),
                                  //       child: Text(
                                  //         'SEARCH FOR A VEHICLE',
                                  //         style: TextStyle(color: Colors.black),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 24),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('vehicles')
                                .where('location.city', isEqualTo: location)
                                .where('isAvailable', isEqualTo: true)
                                .limit(3)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.yellow),
                                );
                              }
                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                      'Sorry! No dealers available currently'),
                                );
                              }

                              final vehicleDocs = snapshot.data!.docs;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Your Recommendations',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.66,
                                      child: GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10.0,
                                          mainAxisSpacing: 12.0,
                                          childAspectRatio: 0.72,
                                        ),
                                        itemCount: vehicleDocs.length,
                                        itemBuilder: (context, index) {
                                          Vehicle vehicle = Vehicle.fromJson(
                                            vehicleDocs[index].data()
                                                as Map<String, dynamic>,
                                          );

                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context)
                          .push(SlidePageRoute(page: VehicleDetailsPage(vehicle: vehicle,)));
                                            },
                                            child:
                                                VehicleCard(vehicle: vehicle),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
          );
  }
}
