import 'package:clean_architecture_poktani/features/crop/domain/entity/request/entity_request_add_crop.dart';
import 'package:equatable/equatable.dart';

class AddCropRequestModel extends Equatable {
  final int? seedId;
  final int? nurseryId;
  final String plantingDate;
  final double plantQuantity;
  final int fieldCoordinatorId;

  const AddCropRequestModel({
    this.seedId,
    this.nurseryId,
    required this.plantingDate,
    required this.plantQuantity,
    required this.fieldCoordinatorId,
  });

  // Konversi dari Object Model menjadi JSON (Map)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'planting_date': plantingDate,
      'plant_quantity': plantQuantity,
      'field_coordinator_id': fieldCoordinatorId,
    };

    if (seedId != null) {
      data['seed_id'] = seedId;
    }

    if (nurseryId != null) {
      data['nursery_id'] = nurseryId;
    }

    return data;
  }

  // Konversi dari object Entity (Domain Layer) menjadi Model (Data Layer)
  factory AddCropRequestModel.fromEntity(EntityRequestAddCrop entity) {
    return AddCropRequestModel(
      seedId: entity.seedId,
      nurseryId: entity.nurseryId,
      plantingDate: entity.plantingDate,
      plantQuantity: entity.plantQuantity,
      fieldCoordinatorId: entity.fieldCoordinatorId,
    );
  }

  // Konversi dari object Model (Data Layer) menjadi Entity (Domain Layer)
  EntityRequestAddCrop toEntity() {
    return EntityRequestAddCrop(
      seedId: seedId,
      nurseryId: nurseryId,
      plantingDate: plantingDate,
      plantQuantity: plantQuantity,
      fieldCoordinatorId: fieldCoordinatorId,
    );
  }

  @override
  List<Object?> get props => [
    seedId,
    nurseryId,
    plantingDate,
    plantQuantity,
    fieldCoordinatorId,
  ];
}
