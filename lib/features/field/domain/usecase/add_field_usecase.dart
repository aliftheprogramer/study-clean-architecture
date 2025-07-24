import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_add_field.dart';

import '../repository/field_repository.dart';

class AddFieldUsecase
    implements Usecase<DataState<ResponseAddField>, AddFieldEntity> {
  @override
  Future<DataState<ResponseAddField>> call({AddFieldEntity? param}) async {
    return sl<FieldRepository>().addField(param!);
  }
}
