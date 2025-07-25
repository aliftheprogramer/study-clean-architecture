import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/core/usecases/usecase.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/request/request_add_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_add_field.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../repository/field_repository.dart';

class AddFieldUseCase {
  final FieldRepository repository;

  // 1. Terima Repository lewat constructor
  const AddFieldUseCase(this.repository);

  // 2. Definisikan method 'call' yang akan dipanggil Cubit
  Future<Either<DataFailed, ResponseAddField>> call(
    AddFieldEntity params,
  ) async {
    // 3. CUKUP PANGGIL REPOSITORY DAN KEMBALIKAN HASILNYA. SELESAI.
    return await repository.addField(params);
  }
}
