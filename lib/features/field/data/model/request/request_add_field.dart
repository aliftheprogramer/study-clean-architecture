// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';

class AddFieldRequestModel {
  // 1. UBAH PROPERTI MENJADI camelCase (Standar Dart)
  final String name;
  final double landArea;
  final String? latitude;
  final String? longitude;
  final String subVillage;
  final String village;
  final String district;
  final int soilTypeId;

  // 2. SESUAIKAN CONSTRUCTOR DENGAN camelCase
  AddFieldRequestModel({
    required this.name,
    required this.landArea,
    this.latitude,
    this.longitude,
    required this.subVillage,
    required this.village,
    required this.district,
    required this.soilTypeId,
  });

  // 3. toMap() MENGHASILKAN JSON snake_case (UNTUK DIKIRIM KE SERVER)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'land_area': landArea, // <-- Kunci JSON tetap snake_case
      'latitude': latitude,
      'longitude': longitude,
      'sub_village': subVillage, // <-- Kunci JSON tetap snake_case
      'village': village,
      'district': district,
      'soil_type_id': soilTypeId, // <-- Kunci JSON tetap snake_case
    };
  }

  // 4. fromEntity() MENERIMA ENTITY DENGAN camelCase
  factory AddFieldRequestModel.fromEntity(AddFieldEntity entity) {
    return AddFieldRequestModel(
      name: entity.name,
      landArea: entity.landArea, // <-- Gunakan properti camelCase dari entity
      latitude: entity.latitude,
      longitude: entity.longitude,
      subVillage:
          entity.subVillage, // <-- Gunakan properti camelCase dari entity
      village: entity.village,
      district: entity.district,
      soilTypeId:
          entity.soilTypeId, // <-- Gunakan properti camelCase dari entity
    );
  }

  String toJson() => json.encode(toMap());

  // Bagian fromMap dan fromJson biasanya tidak terlalu dibutuhkan untuk
  // sebuah request model, tapi jika ada, beginilah cara yang benar:
  factory AddFieldRequestModel.fromMap(Map<String, dynamic> map) {
    return AddFieldRequestModel(
      name: map['name'] as String,
      landArea: (map['land_area'] as num).toDouble(), // Baca snake_case
      latitude: map['latitude'] as String?,
      longitude: map['longitude'] as String?,
      subVillage: map['sub_village'] as String, // Baca snake_case
      village: map['village'] as String,
      district: map['district'] as String,
      soilTypeId: map['soil_type_id'] as int, // Baca snake_case
    );
  }

  factory AddFieldRequestModel.fromJson(String source) =>
      AddFieldRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
