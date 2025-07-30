import 'package:equatable/equatable.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/request/entity_request_add_crop.dart';

class AddCropParams extends Equatable {
  final String fieldId;
  final EntityRequestAddCrop crop;

  const AddCropParams({required this.fieldId, required this.crop});

  @override
  List<Object?> get props => [fieldId, crop];
}
