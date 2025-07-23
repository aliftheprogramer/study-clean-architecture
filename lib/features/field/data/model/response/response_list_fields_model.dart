import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';

class ResponseListFieldsModel {
  final List<ListFieldModel> data;
  final PagingModel? paging;
  final LinksModel? links;

  ResponseListFieldsModel({required this.data, this.paging, this.links});
}

class ListFieldModel {
  final int id;
  final String name;
  final int landArea;
  final String pictureUrl;
  final AddressModel address;
  final String soilType;
  final ActiveCropModel activeCrop;

  ListFieldModel({
    required this.id,
    required this.name,
    required this.landArea,
    required this.pictureUrl,
    required this.address,
    required this.soilType,
    required this.activeCrop,
  });
}

class AddressModel {
  final String subVillage;
  final String village;
  final String district;

  AddressModel({
    required this.subVillage,
    required this.village,
    required this.district,
  });
}

class ActiveCropModel {
  final int id;
  final String seedName;

  ActiveCropModel({required this.id, required this.seedName});
}


class PagingModel {
  
}