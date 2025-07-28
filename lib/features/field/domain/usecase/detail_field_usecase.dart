import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/field_repository.dart';

class GetDetailFieldUseCase
    implements Usecase<DataState<ResponseFieldDetailEntity>, String?> {
  @override
  Future<DataState<ResponseFieldDetailEntity>> call({String? param}) {
    return sl<FieldRepository>().getFieldDetail(int.parse(param!));
  }
}
