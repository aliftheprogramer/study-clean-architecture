import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';
import 'package:equatable/equatable.dart';

class AddCropDirectlyFormState extends Equatable {
  final SeedEntity? selectedSeed;
  final DateTime? selectedDate;
  final String plantQuantity;
  final String fieldCoordinatorId;

  const AddCropDirectlyFormState({
    this.selectedSeed,
    this.selectedDate,
    this.plantQuantity = '',
    this.fieldCoordinatorId = '',
  });

  bool get isFormValid =>
      selectedSeed != null &&
      selectedDate != null &&
      plantQuantity.isNotEmpty &&
      fieldCoordinatorId.isNotEmpty &&
      double.tryParse(plantQuantity) != null &&
      int.tryParse(fieldCoordinatorId) != null;

  AddCropDirectlyFormState copyWith({
    SeedEntity? selectedSeed,
    DateTime? selectedDate,
    String? plantQuantity,
    String? fieldCoordinatorId,
  }) {
    return AddCropDirectlyFormState(
      selectedSeed: selectedSeed ?? this.selectedSeed,
      selectedDate: selectedDate ?? this.selectedDate,
      plantQuantity: plantQuantity ?? this.plantQuantity,
      fieldCoordinatorId: fieldCoordinatorId ?? this.fieldCoordinatorId,
    );
  }

  @override
  List<Object?> get props => [
    selectedSeed,
    selectedDate,
    plantQuantity,
    fieldCoordinatorId,
  ];
}
