// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_add_field.dart';

// ===== Model Utama =====
class ResponseAddFieldsModel {
  final int id;
  final String name;
  final double landArea;
  final String? pictureUrl; // <-- 1. TAMBAHKAN PROPERTI INI
  final AddressModel address;
  final String soilType;
  final ActiveCropModel? activeCrop;

  ResponseAddFieldsModel({
    required this.id,
    required this.name,
    required this.landArea,
    required this.pictureUrl, // <-- 2. TAMBAHKAN DI CONSTRUCTOR
    required this.address,
    required this.soilType,
    this.activeCrop,
  });

  // `toMap` menerjemahkan camelCase Dart ke snake_case JSON
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'land_area': landArea,
      'address': address.toMap(),
      'soil_type': soilType,
      'active_crop': activeCrop?.toMap(),
    };
  }

  // `fromMap` menerjemahkan snake_case JSON ke camelCase Dart
  factory ResponseAddFieldsModel.fromMap(Map<String, dynamic> map) {
    return ResponseAddFieldsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      landArea: (map['land_area'] as num).toDouble(),
      pictureUrl: map['picture_url'] as String?, // <-- 3. BACA DARI JSON
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      soilType: map['soil_type'] as String,
      activeCrop: map['active_crop'] != null
          ? ActiveCropModel.fromMap(map['active_crop'] as Map<String, dynamic>)
          : null,
    );
  }

  // Method untuk konversi ke Entity di Domain Layer
  // ... di dalam kelas ResponseAddFieldsModel
  ResponseAddFieldEntity toEntity() {
    return ResponseAddFieldEntity(
      id: id,
      name: name,
      landArea: landArea,
      pictureUrl: pictureUrl, // <-- GUNAKAN DATA ASLI, BUKAN STRING KOSONG
      address: address.toEntity(),
      soilType: soilType,
      activeCrop: activeCrop?.toEntity(),
    );
  }
}

// ===== Model Alamat (Nested) =====
class AddressModel {
  // Properti sudah benar (camelCase)
  final String subVillage;
  final String village;
  final String district;

  AddressModel({
    required this.subVillage,
    required this.village,
    required this.district,
  });

  // `toMap` harus menghasilkan snake_case
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_village': subVillage,
      'village': village,
      'district': district,
    };
  }

  // `fromMap` harus membaca snake_case dari JSON
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      subVillage: map['sub_village'] as String,
      village: map['village'] as String,
      district: map['district'] as String,
    );
  }

  AddressEntity toEntity() {
    return AddressEntity(
      subVillage: subVillage,
      village: village,
      district: district,
    );
  }
}

// ===== Model Tanaman Aktif (Nested & Nullable) =====
class ActiveCropModel {
  // Gunakan camelCase untuk properti di Dart
  final int id;
  final String seedName;

  ActiveCropModel({required this.id, required this.seedName});

  // `toMap` menghasilkan snake_case
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'seed_name': seedName};
  }

  // `fromMap` membaca snake_case
  factory ActiveCropModel.fromMap(Map<String, dynamic> map) {
    return ActiveCropModel(
      id: map['id'] as int,
      seedName: map['seed_name'] as String,
    );
  }

  ActiveCropEntity toEntity() {
    return ActiveCropEntity(id: id, seedName: seedName);
  }
}
