import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_list_field.dart';
import 'package:dartz/dartz.dart';

abstract class FieldRepository {
  Future<DataState<FieldResponseEntity>> getFields({String? url});
  Future<Either<DataFailed, ResponseAddField>> addField(AddFieldEntity field);
}
