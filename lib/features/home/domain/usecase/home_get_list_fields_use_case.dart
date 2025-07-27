import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';
import 'package:clean_architecture_poktani/features/home/domain/repository/home_repositoy.dart';

class HomeGetListFieldsUseCase
    implements Usecase<DataState<ResponseListFieldHomeEntity>, String?> {
  @override
  Future<DataState<ResponseListFieldHomeEntity>> call({String? param}) {
    return sl<HomeRepository>().getFields();
  }
}
