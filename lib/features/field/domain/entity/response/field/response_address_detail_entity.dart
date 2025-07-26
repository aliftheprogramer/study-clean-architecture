class AddressDetailEntity {
  final double latitude;
  final double longitude;
  final String? hamlet;
  final String? village; // Dibuat nullable
  final String? city; // Dibuat nullable
  final String? county; // Dibuat nullable
  final String? state; // Tambahan untuk state
  final String? city_district; // Tambahan untuk city district

  AddressDetailEntity({
    required this.latitude,
    required this.longitude,
    this.hamlet,
    this.village,
    this.city,
    this.county,
    this.city_district,
    this.state,
  });
}
