import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_list_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/field_repository.dart';

class GetListFieldsUseCase
    implements Usecase<DataState<FieldResponseEntity>, String?> {
  @override
  Future<DataState<FieldResponseEntity>> call({String? param}) {
    return sl<FieldRepository>().getFields();
  }
}
