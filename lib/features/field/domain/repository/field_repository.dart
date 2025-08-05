import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_form_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_list_field.dart';
import 'package:dartz/dartz.dart';

abstract class FieldRepository {
  Future<DataState<FieldResponseEntity>> getFields({String? cursor});
  Future<Either<DataFailed, ResponseRequestFieldFormEntity>> addField(
    RequestFieldFormEntity field,
  );
  Future<DataState<ResponseFieldDetailEntity>> getFieldDetail(int id);
}
