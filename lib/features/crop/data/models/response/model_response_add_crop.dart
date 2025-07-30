import 'package:clean_architecture_poktani/features/crop/domain/entity/response/entity_response_add_crop.dart';
import 'package:equatable/equatable.dart';

// 1. Model Pembungkus Utama
class AddCropResponseModel extends Equatable {
  final String status;
  final String message;
  final DataCropModel data;

  const AddCropResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddCropResponseModel.fromJson(Map<String, dynamic> json) =>
      AddCropResponseModel(
        status: json["status"],
        message: json["message"],
        data: DataCropModel.fromJson(json["data"]),
      );

  // Konversi dari Model ke Entity (Domain Layer)
  EntityResponseAddCrop toEntity() {
    return EntityResponseAddCrop(
      status: status,
      message: message,
      data: data.toEntity(), // Panggil toEntity() pada model di dalamnya
    );
  }

  @override
  List<Object> get props => [status, message, data];
}

// 2. Model untuk Objek "data"
class DataCropModel extends Equatable {
  final int id;
  final int fieldId;
  final int nurseryId;
  final String plantingDate;
  final double plantQuantity;
  final dynamic status;
  final SeedModel seed;
  final CoordinatorModel coordinator;
  final DateTime createdAt;

  const DataCropModel({
    required this.id,
    required this.fieldId,
    required this.nurseryId,
    required this.plantingDate,
    required this.plantQuantity,
    this.status,
    required this.seed,
    required this.coordinator,
    required this.createdAt,
  });

  factory DataCropModel.fromJson(Map<String, dynamic> json) => DataCropModel(
    id: json["id"],
    fieldId: json["field_id"],
    nurseryId: json["nursery_id"],
    plantingDate: json["planting_date"],
    plantQuantity: (json["plant_quantity"] as num).toDouble(),
    status: json["status"],
    seed: SeedModel.fromJson(json["seed"]),
    coordinator: CoordinatorModel.fromJson(json["coordinator"]),
    createdAt: DateTime.parse(json["created_at"]),
  );

  // Konversi dari Model ke Entity
  DataCrop toEntity() {
    return DataCrop(
      id: id,
      fieldId: fieldId,
      nurseryId: nurseryId,
      plantingDate: plantingDate,
      plantQuantity: plantQuantity,
      status: status,
      seed: seed.toEntity(), // Konversi nested model juga
      coordinator: coordinator.toEntity(), // Konversi nested model juga
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fieldId,
    nurseryId,
    plantingDate,
    plantQuantity,
    status,
    seed,
    coordinator,
    createdAt,
  ];
}

// 3. Model untuk Objek "seed"
class SeedModel extends Equatable {
  final int id;
  final String name;
  final String variety;
  final String unit;

  const SeedModel({
    required this.id,
    required this.name,
    required this.variety,
    required this.unit,
  });

  factory SeedModel.fromJson(Map<String, dynamic> json) => SeedModel(
    id: json["id"],
    name: json["name"],
    variety: json["variety"],
    unit: json["unit"],
  );

  // Konversi dari Model ke Entity
  Seed toEntity() {
    return Seed(id: id, name: name, variety: variety, unit: unit);
  }

  @override
  List<Object> get props => [id, name, variety, unit];
}

// 4. Model untuk Objek "coordinator"
class CoordinatorModel extends Equatable {
  final int id;
  final String name;

  const CoordinatorModel({required this.id, required this.name});

  factory CoordinatorModel.fromJson(Map<String, dynamic> json) =>
      CoordinatorModel(id: json["id"], name: json["name"]);

  // Konversi dari Model ke Entity
  Coordinator toEntity() {
    return Coordinator(id: id, name: name);
  }

  @override
  List<Object> get props => [id, name];
}
