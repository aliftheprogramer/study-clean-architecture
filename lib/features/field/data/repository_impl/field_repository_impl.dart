import 'package:clean_architecture_poktani/core/resources/data_state.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/data/model/response/response_list_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/data/source/field_api_services.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response_list_field.dart';
import 'package:clean_architecture_poktani/features/field/domain/repository/field_repository.dart';
import 'package:dio/dio.dart';

class FieldRepositoryImpl implements FieldRepository {
  @override
  Future<DataState<FieldResponseEntity>> getFields({String? url}) async {
    try {
      final httpResponse = await sl<FieldApiServices>().getFields(url: url);

      if (httpResponse.data != null) {
        return DataSuccess(data: httpResponse.data!.toEntity());
      } else {
        return DataFailed(
          httpResponse.error ??
              DioException(requestOptions: RequestOptions(path: '')),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

extension on ResponseListFieldsModel {
  FieldResponseEntity toEntity() {
    return FieldResponseEntity(
      fields: data.map((model) => model.toEntity()).toList(),
      paging: paging?.toEntity(),
      links: links?.toEntity(),
    );
  }
}

extension on ListFieldModel {
  ListFieldEntity toEntity() {
    return ListFieldEntity(
      id: id,
      name: name,
      landArea: landArea,
      pictureUrl: pictureUrl,
      address: address.toEntity(),
      soilType: soilType,
      activeCrop: activeCrop.toEntity(),
    );
  }
}

extension on AddressModel {
  AddressEntity toEntity() {
    return AddressEntity(
      subVillage: subVillage,
      village: village,
      district: district,
    );
  }
}

extension on ActiveCropModel {
  ActiveCropEntity toEntity() {
    return ActiveCropEntity(id: id, seedName: seedName);
  }
}

extension on PagingModel {
  PagingEntity toEntity() {
    return PagingEntity(
      hasNextPage: has_next_page?.toLowerCase() == 'true',
      hasPrevPage: has_prev_page?.toLowerCase() == 'true',
    );
  }
}

extension on LinksModel {
  LinksEntity toEntity() {
    return LinksEntity(next: next, prev: prev);
  }
}
