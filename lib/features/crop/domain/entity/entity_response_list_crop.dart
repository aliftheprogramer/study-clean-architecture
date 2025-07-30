import 'package:equatable/equatable.dart';

/// Representasi dari keseluruhan respons API
class CropResponseEntity extends Equatable {
  final String status;
  final String message;
  final List<CropEntity> data;
  final PagingEntity paging;

  const CropResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.paging,
  });

  factory CropResponseEntity.fromJson(Map<String, dynamic> json) {
    var cropList = (json['data'] as List)
        .map((item) => CropEntity.fromJson(item))
        .toList();

    return CropResponseEntity(
      status: json['status'],
      message: json['message'],
      data: cropList,
      paging: PagingEntity.fromJson(json['paging']),
    );
  }

  // Daftarkan semua properti untuk perbandingan
  @override
  List<Object?> get props => [status, message, data, paging];
}

/// Representasi satu objek tanaman (crop)
class CropEntity extends Equatable {
  final int id;
  final int fieldId;
  final int nurseryId;
  final DateTime plantingDate;
  final double plantQuantity;
  final String status;
  final SeedEntity seed;
  final CoordinatorEntity coordinator;
  final DateTime createdAt;

  const CropEntity({
    required this.id,
    required this.fieldId,
    required this.nurseryId,
    required this.plantingDate,
    required this.plantQuantity,
    required this.status,
    required this.seed,
    required this.coordinator,
    required this.createdAt,
  });

  factory CropEntity.fromJson(Map<String, dynamic> json) {
    return CropEntity(
      id: json['id'],
      fieldId: json['field_id'],
      nurseryId: json['nursery_id'],
      plantingDate: DateTime.parse(json['planting_date']),
      plantQuantity: double.parse(json['plant_quantity']),
      status: json['status'],
      seed: SeedEntity.fromJson(json['seed']),
      coordinator: CoordinatorEntity.fromJson(json['coordinator']),
      createdAt: DateTime.parse(json['created_at']),
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

/// Representasi objek benih (seed)
class SeedEntity extends Equatable {
  final int id;
  final String name;
  final String variety;
  final String unit;

  const SeedEntity({
    required this.id,
    required this.name,
    required this.variety,
    required this.unit,
  });

  factory SeedEntity.fromJson(Map<String, dynamic> json) {
    return SeedEntity(
      id: json['id'],
      name: json['name'],
      variety: json['variety'],
      unit: json['unit'],
    );
  }

  @override
  List<Object?> get props => [id, name, variety, unit];
}

/// Representasi objek koordinator
class CoordinatorEntity extends Equatable {
  final int id;
  final String name;

  const CoordinatorEntity({required this.id, required this.name});

  factory CoordinatorEntity.fromJson(Map<String, dynamic> json) {
    return CoordinatorEntity(id: json['id'], name: json['name']);
  }

  @override
  List<Object?> get props => [id, name];
}

/// Representasi objek paging
class PagingEntity extends Equatable {
  final bool hasNextPage;
  final bool hasPrevPage;

  const PagingEntity({required this.hasNextPage, required this.hasPrevPage});

  factory PagingEntity.fromJson(Map<String, dynamic> json) {
    return PagingEntity(
      hasNextPage: json['has_next_page'],
      hasPrevPage: json['has_prev_page'],
    );
  }

  @override
  List<Object?> get props => [hasNextPage, hasPrevPage];
}
