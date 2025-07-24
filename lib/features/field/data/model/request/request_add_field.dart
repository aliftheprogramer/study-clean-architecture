// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';

class AddFieldRequestModel {
  final String name;
  final double landArea;
  final String latitude;
  final String longitude;
  final String subVillage;
  final String village;
  final String district;
  final int soilTypeId;

  AddFieldRequestModel({
    required this.name,
    required this.landArea,
    required this.latitude,
    required this.longitude,
    required this.subVillage,
    required this.village,
    required this.district,
    required this.soilTypeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'landArea': landArea,
      'latitude': latitude,
      'longitude': longitude,
      'subVillage': subVillage,
      'village': village,
      'district': district,
      'soilTypeId': soilTypeId,
    };
  }

  // Kode yang benar di dalam kelas AddFieldRequestModel
  factory AddFieldRequestModel.fromEntity(AddFieldEntity entity) {
    // <-- UBAH TIPE PARAMETER DI SINI
    return AddFieldRequestModel(
      name: entity.name,
      landArea: entity.landArea,
      latitude: entity.latitude,
      longitude: entity.longitude,
      subVillage: entity.subVillage,
      village: entity.village,
      district: entity.district,
      soilTypeId: entity.soilTypeId,
    );
  }

  factory AddFieldRequestModel.fromMap(Map<String, dynamic> map) {
    return AddFieldRequestModel(
      name: map['name'] as String,
      landArea: map['landArea'] as double,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      subVillage: map['subVillage'] as String,
      village: map['village'] as String,
      district: map['district'] as String,
      soilTypeId: map['soilTypeId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddFieldRequestModel.fromJson(String source) =>
      AddFieldRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
