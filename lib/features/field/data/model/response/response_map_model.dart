import 'dart:convert';


class NominatimResponseModel {
  final int? placeId;
  final String? displayName;
  final double? lat;
  final double? lon;
  final AddressModel? address;
  final List<String>? boundingbox;

  NominatimResponseModel({
    this.placeId,
    this.displayName,
    this.lat,
    this.lon,
    this.address,
    this.boundingbox,
  });

  factory NominatimResponseModel.fromMap(Map<String, dynamic> map) {
    return NominatimResponseModel(
      placeId: map['place_id'] as int?,
      displayName: map['display_name'] as String?,
      lat: map['lat'] != null ? double.tryParse(map['lat']) : null,
      lon: map['lon'] != null ? double.tryParse(map['lon']) : null,
      address: map['address'] != null
          ? AddressModel.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      boundingbox: map['boundingbox'] != null
          ? List<String>.from(map['boundingbox'] as List)
          : null,
    );
  }

  factory NominatimResponseModel.fromJson(String source) =>
      NominatimResponseModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

// Kelas untuk objek "address" yang ada di dalam JSON
class AddressModel {
  final String? amenity;
  final String? houseNumber;
  final String? road;
  final String? village;
  final String? subdistrict;
  final String? city;
  final String? state;
  final String? postcode;
  final String? country;
  final String? countryCode;

  AddressModel({
    this.amenity,
    this.houseNumber,
    this.road,
    this.village,
    this.subdistrict,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.countryCode,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      amenity: map['amenity'] as String?,
      houseNumber: map['house_number'] as String?,
      road: map['road'] as String?,
      village: map['village'] as String?,
      subdistrict: map['subdistrict'] as String?,
      city: map['city'] as String?,
      state: map['state'] as String?,
      postcode: map['postcode'] as String?,
      country: map['country'] as String?,
      countryCode: map['country_code'] as String?,
    );
  }

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
