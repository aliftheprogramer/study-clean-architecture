// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/response_list_field.dart';

class ResponseListFieldsModel {
  final List<ListFieldModel> data;
  final PagingModel? paging;
  final LinksModel? links;

  ResponseListFieldsModel({required this.data, this.paging, this.links});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'paging': paging?.toMap(),
      'links': links?.toMap(),
    };
  }

  factory ResponseListFieldsModel.fromMap(Map<String, dynamic> map) {
    return ResponseListFieldsModel(
      data: List<ListFieldModel>.from(
        (map['data'] as List).map<ListFieldModel>(
          (x) => ListFieldModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      paging: map['paging'] != null
          ? PagingModel.fromMap(map['paging'] as Map<String, dynamic>)
          : null,
      links: map['links'] != null
          ? LinksModel.fromMap(map['links'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseListFieldsModel.fromJson(String source) =>
      ResponseListFieldsModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  FieldResponseEntity toEntity() {
    return FieldResponseEntity(
      fields: data.map((e) => e.toEntity()).toList(),
      paging: paging?.toEntity(),
      links: links?.toEntity(),
    );
  }
}

class ListFieldModel {
  final int id;
  final String? name;
  final double? landArea;
  final String? pictureUrl;
  final AddressModel? address;
  final String? soilType;
  final ActiveCropModel? activeCrop;

  ListFieldModel({
    required this.id,
    required this.name,
    required this.landArea,
    required this.pictureUrl,
    required this.address,
    required this.soilType,
    required this.activeCrop,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'landArea': landArea,
      'pictureUrl': pictureUrl,
      'address': address?.toMap(),
      'soilType': soilType,
      'activeCrop': activeCrop?.toMap(),
    };
  }

  factory ListFieldModel.fromMap(Map<String, dynamic> map) {
    return ListFieldModel(
      id: map['id'] as int,
      name: map['name'] != null ? map['name'] as String : null,
      landArea: map['landArea'] != null ? map['landArea'] as double : null,
      pictureUrl: map['pictureUrl'] != null
          ? map['pictureUrl'] as String
          : null,
      address: map['address'] != null
          ? AddressModel.fromMap(map['address'] as Map<String, dynamic>)
          : null,
      soilType: map['soilType'] != null ? map['soilType'] as String : null,
      activeCrop: map['activeCrop'] != null
          ? ActiveCropModel.fromMap(map['activeCrop'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListFieldModel.fromJson(String source) =>
      ListFieldModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ListFieldEntity toEntity() {
    return ListFieldEntity(
      id: id,
      name: name,
      landArea: landArea,
      pictureUrl: pictureUrl,
      address: address?.toEntity(),
      soilType: soilType,
      activeCrop: activeCrop?.toEntity(),
    );
  }
}

class AddressModel {
  final String? sub_village;
  final String? village;
  final String district;

  AddressModel({
    required this.sub_village,
    required this.village,
    required this.district,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_village': sub_village, // Perbaikan: Menghapus titik koma
      'village': village,
      'district': district,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      sub_village:
          map['sub_village'] !=
              null // Perbaikan: Menghapus titik koma
          ? map['sub_village'] as String
          : null,
      village: map['village'] != null ? map['village'] as String : null,
      district: map['district'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  AddressEntity toEntity() {
    return AddressEntity(
      subVillage: sub_village,
      village: village,
      district: district,
    );
  }
}

class ActiveCropModel {
  final int id;
  final String? seedName;

  ActiveCropModel({required this.id, required this.seedName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'seedName': seedName};
  }

  factory ActiveCropModel.fromMap(Map<String, dynamic> map) {
    return ActiveCropModel(
      id: map['id'] as int,
      seedName: map['seedName'] != null ? map['seedName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveCropModel.fromJson(String source) =>
      ActiveCropModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ActiveCropEntity toEntity() {
    return ActiveCropEntity(id: id, seedName: seedName);
  }
}

class PagingModel {
  final bool? has_next_page;
  final bool? has_prev_page;
  final CursorsModel? cursors;

  PagingModel({this.has_next_page, this.has_prev_page, this.cursors});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'has_next_page': has_next_page,
      'has_prev_page': has_prev_page,
      'cursors': cursors?.toMap(),
    };
  }

  factory PagingModel.fromMap(Map<String, dynamic> map) {
    return PagingModel(
      has_next_page: map['has_next_page'] != null
          ? map['has_next_page'] as bool
          : null,
      has_prev_page: map['has_prev_page'] != null
          ? map['has_prev_page'] as bool
          : null,
      cursors: map['cursors'] != null
          ? CursorsModel.fromMap(map['cursors'] as Map<String, dynamic>)
          : null,
    );
  }

  PagingEntity toEntity() {
    return PagingEntity(
      hasNextPage: has_next_page ?? false,
      hasPrevPage: has_prev_page ?? false,
      cursors: cursors?.toEntity(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PagingModel.fromJson(String source) =>
      PagingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LinksModel {
  final String? next;
  final String? prev;

  LinksModel({this.next, this.prev});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'next': next, 'prev': prev};
  }

  factory LinksModel.fromMap(Map<String, dynamic> map) {
    return LinksModel(
      next: map['next'] != null ? map['next'] as String : null,
      prev: map['prev'] != null ? map['prev'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LinksModel.fromJson(String source) =>
      LinksModel.fromMap(json.decode(source) as Map<String, dynamic>);
  LinksEntity toEntity() {
    return LinksEntity(next: next, prev: prev);
  }
}

class CursorsModel {
  final String? next;
  final String? prev;

  CursorsModel({this.next, this.prev});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'next': next, 'prev': prev};
  }

  factory CursorsModel.fromMap(Map<String, dynamic> map) {
    return CursorsModel(
      next: map['next'] != null ? map['next'] as String : null,
      prev: map['prev'] != null ? map['prev'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CursorsModel.fromJson(String source) =>
      CursorsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  CursorsEntity toEntity() {
    return CursorsEntity(next: next, prev: prev);
  }
}
