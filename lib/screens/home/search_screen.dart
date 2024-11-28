import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:rider/components/text_field.dart';
import 'package:rider/components/text_field_alt.dart';
import 'package:rider/components/vehicle_card.dart';
import 'package:rider/models/vehicle.dart';
import 'package:rider/providers/user_provider.dart';
import 'package:rider/screens/home/filter_screen.dart';
import 'package:rider/screens/home/locations_screen.dart';
import 'package:rider/screens/home/vehicle_details_page.dart';
import 'package:rider/services/navigation_services.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 35,
        titleSpacing: 10,
        toolbarHeight: 90,
        backgroundColor: AppColors.primary,
        title: MyTextformfield(
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
          ),
        ),
      ),
      body: Column(
        children: [
          // SizedBox(height: 35),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
              child: null),
          searchText.isNotEmpty
              ? Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('vehicles')
                        .where("name", isGreaterThanOrEqualTo: searchText)
                        .where('location.city', isEqualTo: Provider.of<UserProvider>(context, listen: false).getUser.location!)
                        .where('isAvailable', isEqualTo: true)
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
                              'No results found!'),
                        );
                      }

                      final vehicleDocs = snapshot.data!.docs;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height,
                          child: GridView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          VehicleDetailsPage(
                                              vehicle: vehicle),
                                    ),
                                  );
                                },
                                child:
                                    VehicleCard(vehicle: vehicle),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  )
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
                              fontWeight: FontWeight.w400,
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
