import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/response_list_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response_list_field.dart';

abstract class FieldRepository {
  Future<DataState<FieldResponseEntity>> getFields({String? url});
}
