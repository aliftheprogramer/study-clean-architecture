// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final String? subdistrict; //kecamatan
  final String? city;
  final String? state; //provonsi
  final String? postcode;
  final String? county; //kabupaten
  final String? countryCode;
  final String? municipality;
  final String? name; // dusun
  final String? hamlet; // dusun
  final String? town; //kecamatan
  final String? suburb; //kecamatan
  final String? city_district; //kecamatan

  AddressModel({
    this.amenity,
    this.houseNumber,
    this.road,
    this.village,
    this.subdistrict,
    this.city,
    this.state,
    this.postcode,
    this.county,
    this.town,
    this.suburb,
    this.city_district,
    this.municipality,
    this.name,
    this.hamlet,
    this.countryCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amenity': amenity,
      'houseNumber': houseNumber,
      'road': road,
      'village': village,
      'subdistrict': subdistrict,
      'city': city,
      'state': state,
      'postcode': postcode,
      'county': county,
      'countryCode': countryCode,
      'municipality': municipality,
      'name': name,
      'hamlet': hamlet,
      'town': town,
      'suburb': suburb,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      amenity: map['amenity'] != null ? map['amenity'] as String : null,
      houseNumber: map['houseNumber'] != null
          ? map['houseNumber'] as String
          : null,
      road: map['road'] != null ? map['road'] as String : null,
      village: map['village'] != null ? map['village'] as String : null,
      subdistrict: map['subdistrict'] != null
          ? map['subdistrict'] as String
          : null,
      city: map['city'] != null ? map['city'] as String : null,
      state: map['state'] != null ? map['state'] as String : null,
      postcode: map['postcode'] != null ? map['postcode'] as String : null,
      county: map['county'] != null ? map['county'] as String : null,
      countryCode: map['countryCode'] != null
          ? map['countryCode'] as String
          : null,
      municipality: map['municipality'] != null
          ? map['municipality'] as String
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      hamlet: map['hamlet'] != null ? map['hamlet'] as String : null,
      town: map['town'] != null ? map['town'] as String : null,
      suburb: map['suburb'] != null ? map['suburb'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
