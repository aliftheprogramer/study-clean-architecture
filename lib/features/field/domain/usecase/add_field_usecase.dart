import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_form_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_add_field.dart';
import 'package:dartz/dartz.dart';

import '../repository/field_repository.dart';

class AddFieldUseCase
    implements
        Usecase<
          Either<DataFailed, ResponseRequestFieldFormEntity>,
          RequestFieldFormEntity
        > {
  @override
  Future<Either<DataFailed, ResponseRequestFieldFormEntity>> call({
    RequestFieldFormEntity? param,
  }) async {
    return await sl<FieldRepository>().addField(param!);
  }
}
