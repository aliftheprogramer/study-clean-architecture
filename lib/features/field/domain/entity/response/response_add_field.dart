import 'package:clean_architecture_poktani/features/field/data/model/response/response_list_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';

class ResponseAddField {
  final ListFieldEntity data; // <-- Ganti menjadi tipe Entity

  ResponseAddField({required this.data});
}
