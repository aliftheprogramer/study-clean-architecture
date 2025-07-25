import 'package:clean_architecture_poktani/features/field/data/model/response/response_list_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';

class ResponseAddField {
  final int id;
  final String? name;
  final double? landArea;
  final String? pictureUrl;
  final AddressEntity? address;
  final String? soilType;
  final ActiveCropEntity? activeCrop;

  ResponseAddField({
    required this.id,
    required this.name,
    required this.landArea,
    required this.pictureUrl,
    required this.address,
    required this.soilType,
    required this.activeCrop,
  });
}
