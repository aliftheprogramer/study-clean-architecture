import 'package:equatable/equatable.dart';

class EntityRequestAddCrop extends Equatable {
  final int? seedId; // Menjadi nullable
  final int? nurseryId; // Properti baru, nullable
  final String plantingDate;
  final double plantQuantity;
  final int fieldCoordinatorId;

  const EntityRequestAddCrop({
    this.seedId,
    this.nurseryId,
    required this.plantingDate,
    required this.plantQuantity,
    required this.fieldCoordinatorId,
  }) : assert(
         (seedId != null && nurseryId == null) ||
             (seedId == null && nurseryId != null),
         'Hanya boleh ada salah satu antara seedId atau nurseryId',
       );

  @override
  List<Object?> get props => [
    seedId,
    nurseryId,
    plantingDate,
    plantQuantity,
    fieldCoordinatorId,
  ];
}
