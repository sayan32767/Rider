import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:rider/models/vehicle.dart';
import 'package:rider/screens/chat/chat_screen.dart';
import 'package:rider/screens/profile/profile_screen.dart';
import 'package:rider/services/navigation_services.dart';
import 'package:rider/services/vehicle_service.dart';
import 'package:rider/utils/colors.dart';
import 'package:rider/utils/gradient_scaffold.dart';
import 'package:rider/models/user.dart' as model;

class VehicleDetailsPage extends StatefulWidget {
  final Vehicle vehicle;
  const VehicleDetailsPage({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  State<VehicleDetailsPage> createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  late model.User? user;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getDealerDetails().then((value) {
      print(value);
      setState(() {
        user = value;
        _isLoading = false;
      });
    });
  }

  Future<model.User?> getDealerDetails() async {
    setState(() {
      _isLoading = true;
    });
    final snap =
        await VehicleService().fetchSellerDetails(widget.vehicle.sellerId);
    if (snap == null) return null;
    return model.User.fromSnap(snap);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? GradientScaffold(
            body: Center(
                child: CircularProgressIndicator(
            color: Colors.yellow,
          )))
        : GradientScaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(MingCute.left_line, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              automaticallyImplyLeading: false,
              leadingWidth: 35,
              titleSpacing: 10,
              backgroundColor: AppColors.primary,
              title: Text('${widget.vehicle.name}'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vehicle Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.vehicle.imageUrl,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Vehicle Details
                    Text(
                      widget.vehicle.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.vehicle.description,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    SizedBox(height: 16),

                    // Divider(),

                    // SizedBox(height: 16),

                    Text(
                      "Price: ₹${widget.vehicle.price.toStringAsFixed(0)}/day",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow),
                    ),

                    SizedBox(height: 16),

                    Divider(),

                    SizedBox(height: 16),

                    Text(
                      "Fuel Type: ${widget.vehicle.fuelType}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Mileage: ${widget.vehicle.mileage} km/l",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Year bought: ${widget.vehicle.buyingYear}",
                      style: const TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 16),

                    Divider(),

                    SizedBox(height: 16),

                    Text(
                      "Dealer Details",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),

                    SizedBox(height: 16),

                    Text(
                      "${user?.name} (${user?.username})",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      user?.email ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      user?.location ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      DateFormat("MMMM d, y").format(DateTime.tryParse(user
                                              ?.joiningDate!
                                              .toIso8601String() ??
                                          '')
                                      ?.toLocal() ??
                                  DateTime(0)) ==
                              "December 30, 1899"
                          ? "History unavailable"
                          : DateFormat("MMMM d, y").format(DateTime.tryParse(
                                      user?.joiningDate!.toIso8601String() ??
                                          '')
                                  ?.toLocal() ??
                              DateTime.now()),
                      style: const TextStyle(fontSize: 16),
                    ),

                    SizedBox(height: 16),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            SlidePageRoute(page: AccountScreen(user: user!)));
                      },
                      child: Text(
                        "View Dealer Details",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.yellowAccent),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Divider(),

                    // SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Booking ${widget.vehicle.name}");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 210, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Book Now",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(SlidePageRoute(
                            page: ChatScreen(
                          recipientEmail: user!.email,
                          recipientUsername: user!.username,
                        )));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 210, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Chat Now",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
