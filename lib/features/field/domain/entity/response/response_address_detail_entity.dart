class AddressDetailEntity {
  final double latitude;
  final double longitude;
  final String? road; // Dibuat nullable
  final String? village; // Dibuat nullable
  final String? city; // Dibuat nullable
  final String? country; // Dibuat nullable
  final String? amenity; // Tambahan untuk amenity
  final String? subdistrict; // Tambahan untuk subdistrict
  final String? state; // Tambahan untuk state

  AddressDetailEntity({
    required this.latitude,
    required this.longitude,
    this.road,
    this.village,
    this.city,
    this.country,
    this.amenity,
    this.subdistrict,
    this.state,
  });
}
