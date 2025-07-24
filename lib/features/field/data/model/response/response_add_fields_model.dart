// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_poktani/features/field/data/model/response/response_list_fields_model.dart';

class ResponseAddFieldsModel {
  final ListFieldModel data;
  final PagingModel? paging;
  final LinksModel? links;

  ResponseAddFieldsModel({required this.data, this.paging, this.links});

  ResponseAddFieldsModel copyWith({
    ListFieldModel? data,
    PagingModel? paging,
    LinksModel? links,
  }) {
    return ResponseAddFieldsModel(
      data: data ?? this.data,
      paging: paging ?? this.paging,
      links: links ?? this.links,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
      'paging': paging?.toMap(),
      'links': links?.toMap(),
    };
  }

  factory ResponseAddFieldsModel.fromMap(Map<String, dynamic> map) {
    return ResponseAddFieldsModel(
      data: ListFieldModel.fromMap(map['data'] as Map<String, dynamic>),
      paging: map['paging'] != null
          ? PagingModel.fromMap(map['paging'] as Map<String, dynamic>)
          : null,
      links: map['links'] != null
          ? LinksModel.fromMap(map['links'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseAddFieldsModel.fromJson(String source) =>
      ResponseAddFieldsModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() =>
      'ResponseAddFieldsModel(data: $data, paging: $paging, links: $links)';

  @override
  bool operator ==(covariant ResponseAddFieldsModel other) {
    if (identical(this, other)) return true;

    return other.data == data && other.paging == paging && other.links == links;
  }

  @override
  int get hashCode => data.hashCode ^ paging.hashCode ^ links.hashCode;
}
