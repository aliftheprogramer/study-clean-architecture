// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';

class ResponseAddFieldsModel {
  final int id;
  final String name;
  final double land_area;
  final AddressModel address;
  final String soil_type;
  final ActiveCropModel? active_crop;

  ResponseAddFieldsModel({
    required this.id,
    required this.name,
    required this.land_area,
    required this.address,
    required this.soil_type,
    this.active_crop,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'land_area': land_area,
      'address': address.toMap(),
      'soil_type': soil_type,
      'active_crop': active_crop?.toMap(),
    };
  }

  factory ResponseAddFieldsModel.fromMap(Map<String, dynamic> map) {
    return ResponseAddFieldsModel(
      id: map['id'] as int,
      name: map['name'] as String,
      land_area: map['land_area'] as double,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      soil_type: map['soil_type'] as String,
      active_crop: map['active_crop'] != null
          ? ActiveCropModel.fromMap(map['active_crop'] as Map<String, dynamic>)
          : null,
    );
  }

  factory ResponseAddFieldsModel.fromJson(String source) =>
      ResponseAddFieldsModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

class AddressModel {
  final String subVillage;
  final String village;
  final String district;

  AddressModel({
    required this.subVillage,
    required this.village,
    required this.district,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    subVillage: json["sub_village"],
    village: json["village"],
    district: json["district"],
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subVillage': subVillage,
      'village': village,
      'district': district,
    };
  }

  AddressEntity toEntity() {
    return AddressEntity(
      subVillage: this.subVillage,
      village: this.village,
      district: this.district,
    );
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      subVillage: map['subVillage'] as String,
      village: map['village'] as String,
      district: map['district'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}

class ActiveCropModel {
  final int id;
  final String seed_name;

  ActiveCropModel({required this.id, required this.seed_name});

  factory ActiveCropModel.fromJson(Map<String, dynamic> json) =>
      ActiveCropModel(id: json["id"], seed_name: json["seed_name"]);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'seed_name': seed_name};
  }

  ActiveCropEntity toEntity() {
    return ActiveCropEntity(id: id, seedName: seed_name);
  }

  factory ActiveCropModel.fromMap(Map<String, dynamic> map) {
    return ActiveCropModel(
      id: map['id'] as int,
      seed_name: map['seed_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
