import 'package:equatable/equatable.dart';

// 1. Class Pembungkus Utama
class EntityResponseAddCrop extends Equatable {
  final String status;
  final String message;
  final DataCrop data;

  const EntityResponseAddCrop({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object> get props => [status, message, data];
}

// 2. Class untuk Objek "data"
class DataCrop extends Equatable {
  final int id;
  final int fieldId;
  final int nurseryId;
  final String plantingDate;
  final double plantQuantity;
  final dynamic status; // Bisa String atau null
  final Seed seed;
  final Coordinator coordinator;
  final DateTime createdAt;

  const DataCrop({
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

// 3. Class untuk Objek "coordinator"
class Coordinator extends Equatable {
  final int id;
  final String name;

  const Coordinator({required this.id, required this.name});

  @override
  List<Object> get props => [id, name];
}

// 4. Class untuk Objek "seed"
class Seed extends Equatable {
  final int id;
  final String name;
  final String variety;
  final String unit;

  const Seed({
    required this.id,
    required this.name,
    required this.variety,
    required this.unit,
  });

  @override
  List<Object> get props => [id, name, variety, unit];
}
