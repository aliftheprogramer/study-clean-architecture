// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/data/model/response/field/response_list_fields_model.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';

class ResponseSoilTypeModel {
  final List<SoilTypeModel>? data;
  final PagingModel? paging;
  final LinksModel? links;

  ResponseSoilTypeModel({required this.data, this.paging, this.links});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.map((x) => x.toMap()).toList(),
      'paging': paging?.toMap(),
      'links': links?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory ResponseSoilTypeModel.fromJson(String source) =>
      ResponseSoilTypeModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  ResponseSoilTypeEntitiy toEntity() {
    return ResponseSoilTypeEntitiy(
      data: data?.map((e) => e.toEntity()).toList(),
      paging: paging?.toEntity(),
      links: links?.toEntity(),
    );
  }

  factory ResponseSoilTypeModel.fromMap(Map<String, dynamic> map) {
    return ResponseSoilTypeModel(
      data: List<SoilTypeModel>.from(
        (map['data'] as List<int>).map<SoilTypeModel>(
          (x) => SoilTypeModel.fromMap(x as Map<String, dynamic>),
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
}

class SoilTypeModel {
  final int id;
  final String name;
  final String description;
  final String created_at;
  final String updated_at;

  SoilTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.created_at,
    required this.updated_at,
  });

  SoilTypeModel copyWith({
    int? id,
    String? name,
    String? description,
    String? created_at,
    String? updated_at,
  }) {
    return SoilTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }

  factory SoilTypeModel.fromMap(Map<String, dynamic> map) {
    return SoilTypeModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
    );
  }

  SoilTypeEntitiy toEntity() {
    return SoilTypeEntitiy(
      id: id,
      name: name,
      description: description,
      createdAt: created_at,
      updatedAt: updated_at,
    );
  }

  String toJson() => json.encode(toMap());

  factory SoilTypeModel.fromJson(String source) =>
      SoilTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SoilTypeModel(id: $id, name: $name, description: $description, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(covariant SoilTypeModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.created_at == created_at &&
        other.updated_at == updated_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode;
  }
}
