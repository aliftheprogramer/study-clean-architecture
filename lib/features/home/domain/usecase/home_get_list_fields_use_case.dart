// file: features/home/domain/usecase/home_get_list_fields_use_case.dart

import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart'; // Pastikan path ini benar
import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';
import 'package:clean_architecture_poktani/features/home/domain/repository/home_repositoy.dart';

class HomeGetListFieldsUseCase
    implements
        Usecase<
          DataState<ResponseListFieldHomeEntity>,
          HomeGetListFieldsUseCaseParams
        > {
  final HomeRepository _homeRepository = sl<HomeRepository>();

  @override
  // Tandatangan method HARUS SAMA PERSIS dengan base class
  Future<DataState<ResponseListFieldHomeEntity>> call({
    HomeGetListFieldsUseCaseParams? param, // Ganti nama & tambahkan '?'
  }) {
    // Sesuaikan dengan nama parameter yang baru
    return _homeRepository.getFields(cursor: param?.cursor);
  }
}

// Class ini tetap sama
class HomeGetListFieldsUseCaseParams {
  final String? cursor;
  const HomeGetListFieldsUseCaseParams({this.cursor});
}
