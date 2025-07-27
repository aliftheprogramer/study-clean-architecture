import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';

abstract class HomeRepository {
  Future<DataState<ResponseListFieldHomeEntity>> getFields();
}
