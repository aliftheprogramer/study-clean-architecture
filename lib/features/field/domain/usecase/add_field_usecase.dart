import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_add_field.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../repository/field_repository.dart';

class AddFieldUseCase
    implements Usecase<Either<DataFailed, ResponseAddField>, AddFieldEntity> {
  @override
  Future<Either<DataFailed, ResponseAddField>> call({
    AddFieldEntity? param,
  }) async {
    return await sl<FieldRepository>().addField(param!);
  }
}
