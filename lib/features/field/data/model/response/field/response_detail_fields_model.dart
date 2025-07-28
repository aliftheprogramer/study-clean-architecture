import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';

// Kelas Model untuk seluruh respons
class ResponseFieldDetailModel {
  final String status;
  final String message;
  final FieldDetailModel data;

  ResponseFieldDetailModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ResponseFieldDetailModel.fromMap(Map<String, dynamic> map) {
    return ResponseFieldDetailModel(
      status: map['status'] as String,
      message: map['message'] as String,
      data: FieldDetailModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory ResponseFieldDetailModel.fromJson(String source) =>
      ResponseFieldDetailModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
  ResponseFieldDetailEntity toEntity() {
    return ResponseFieldDetailEntity(
      status: status,
      message: message,
      // Panggil .toEntity() pada data di dalamnya
      data: data.toEntity(),
    );
  }
}

// Kelas Model untuk objek 'data'
class FieldDetailModel {
  final int id;
  final String name;
  final OwnerModel owner;
  final int land_area;
  final String? picture_url;
  final AddressModel address;
  final CoordinatesModel coordinates;
  final String soil_type;
  final String created_at;
  final String updated_at;
  final ActiveCropDetailModel? active_crop;

  FieldDetailModel({
    required this.id,
    required this.name,
    required this.owner,
    required this.land_area,
    this.picture_url,
    required this.address,
    required this.coordinates,
    required this.soil_type,
    required this.created_at,
    required this.updated_at,
    this.active_crop,
  });

  factory FieldDetailModel.fromMap(Map<String, dynamic> map) {
    return FieldDetailModel(
      id: map['id'] as int,
      name: map['name'] as String,
      owner: OwnerModel.fromMap(map['owner'] as Map<String, dynamic>),
      land_area: map['land_area'] as int,
      picture_url: map['picture_url'] != null
          ? map['picture_url'] as String
          : null,
      address: AddressModel.fromMap(map['address'] as Map<String, dynamic>),
      coordinates: CoordinatesModel.fromMap(
        map['coordinates'] as Map<String, dynamic>,
      ),
      soil_type: map['soil_type'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      active_crop: map['active_crop'] != null
          ? ActiveCropDetailModel.fromMap(
              map['active_crop'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  factory FieldDetailModel.fromJson(String source) =>
      FieldDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FieldDetailEntity toEntity() {
    return FieldDetailEntity(
      id: id,
      name: name,
      owner: owner.toEntity(),
      landArea: land_area,
      pictureUrl: picture_url,
      address: address.toEntity(),
      coordinates: coordinates.toEntity(),
      soilType: soil_type,
      createdAt: created_at,
      updatedAt: updated_at,
      activeCrop: active_crop?.toEntity(),
    );
  }
}

// Kelas-kelas model pendukung
class OwnerModel {
  final int id;
  final String name;

  OwnerModel({required this.id, required this.name});

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(id: map['id'] as int, name: map['name'] as String);
  }

  OwnerEntity toEntity() {
    return OwnerEntity(id: id, name: name);
  }
}

class AddressModel {
  final String sub_village;
  final String village;
  final String district;

  AddressModel({
    required this.sub_village,
    required this.village,
    required this.district,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      sub_village: map['sub_village'] as String,
      village: map['village'] as String,
      district: map['district'] as String,
    );
  }

  AddressEntity toEntity() {
    return AddressEntity(
      subVillage: sub_village,
      village: village,
      district: district,
    );
  }
}

class CoordinatesModel {
  final String latitude;
  final String longitude;

  CoordinatesModel({required this.latitude, required this.longitude});

  factory CoordinatesModel.fromMap(Map<String, dynamic> map) {
    return CoordinatesModel(
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }

  CoordinatesEntity toEntity() {
    return CoordinatesEntity(latitude: latitude, longitude: longitude);
  }
}

class ActiveCropDetailModel {
  final int id;
  final String planting_date;
  final SeedModel seed;
  final String coordinator_name;
  final List<FertilizerUsageModel> fertilizers_used;
  final List<PesticideUsageModel> pesticides_used;

  ActiveCropDetailModel({
    required this.id,
    required this.planting_date,
    required this.seed,
    required this.coordinator_name,
    required this.fertilizers_used,
    required this.pesticides_used,
  });

  factory ActiveCropDetailModel.fromMap(Map<String, dynamic> map) {
    return ActiveCropDetailModel(
      id: map['id'] as int,
      planting_date: map['planting_date'] as String,
      seed: SeedModel.fromMap(map['seed'] as Map<String, dynamic>),
      coordinator_name: map['coordinator_name'] as String,
      fertilizers_used: List<FertilizerUsageModel>.from(
        (map['fertilizers_used'] as List<dynamic>).map<FertilizerUsageModel>(
          (x) => FertilizerUsageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pesticides_used: List<PesticideUsageModel>.from(
        (map['pesticides_used'] as List<dynamic>).map<PesticideUsageModel>(
          (x) => PesticideUsageModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  ActiveCropDetailEntity toEntity() {
    return ActiveCropDetailEntity(
      id: id,
      plantingDate: planting_date,
      seed: seed.toEntity(),
      coordinatorName: coordinator_name,
      fertilizersUsed: fertilizers_used.map((e) => e.toEntity()).toList(),
      pesticidesUsed: pesticides_used.map((e) => e.toEntity()).toList(),
    );
  }
}

class SeedModel {
  final String name;
  final String variety;

  SeedModel({required this.name, required this.variety});

  factory SeedModel.fromMap(Map<String, dynamic> map) {
    return SeedModel(
      name: map['name'] as String,
      variety: map['variety'] as String,
    );
  }

  SeedEntity toEntity() {
    return SeedEntity(name: name, variety: variety);
  }
}

class FertilizerUsageModel {
  final String application_date;
  final String name;
  final int quantity;
  final String unit;

  FertilizerUsageModel({
    required this.application_date,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory FertilizerUsageModel.fromMap(Map<String, dynamic> map) {
    return FertilizerUsageModel(
      application_date: map['application_date'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      unit: map['unit'] as String,
    );
  }

  FertilizerUsageEntity toEntity() {
    return FertilizerUsageEntity(
      applicationDate: application_date,
      name: name,
      quantity: quantity,
      unit: unit,
    );
  }
}

class PesticideUsageModel {
  final String application_date;
  final String name;
  final int quantity;
  final String unit;

  PesticideUsageModel({
    required this.application_date,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory PesticideUsageModel.fromMap(Map<String, dynamic> map) {
    return PesticideUsageModel(
      application_date: map['application_date'] as String,
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      unit: map['unit'] as String,
    );
  }

  PesticideUsageEntity toEntity() {
    return PesticideUsageEntity(
      applicationDate: application_date,
      name: name,
      quantity: quantity,
      unit: unit,
    );
  }
}
