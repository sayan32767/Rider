class Location {
  String city;
  List<String> locations;

  Location({required this.city, required this.locations});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'] ?? '',
      locations: List<String>.from(json['locations'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'locations': locations,
    };
  }
}