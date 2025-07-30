import 'package:equatable/equatable.dart';
import 'package:clean_architecture_poktani/features/units/domain/entity/unit_list_response_entity.dart';

class UnitListResponseModel extends Equatable {
  final String status;
  final String message;
  final List<UnitModel> data;
  final PagingModel? paging;
  final LinksModel? links;

  const UnitListResponseModel({
    required this.status,
    required this.message,
    required this.data,
    this.paging,
    this.links,
  });

  factory UnitListResponseModel.fromJson(Map<String, dynamic> json) {
    return UnitListResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => UnitModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      paging: json['paging'] != null
          ? PagingModel.fromJson(json['paging'])
          : null,
      links: json['links'] != null ? LinksModel.fromJson(json['links']) : null,
    );
  }

  UnitListResponseEntity toEntity() {
    return UnitListResponseEntity(
      status: status,
      message: message,
      data: data.map((e) => e.toEntity()).toList(),
      paging: paging?.toEntity(),
      links: links?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [status, message, data, paging, links];
}

class UnitModel extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UnitModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as int,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  UnitEntity toEntity() {
    return UnitEntity(
      id: id,
      name: name,
      symbol: symbol,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props => [id, name, symbol, createdAt, updatedAt];
}

class PagingModel extends Equatable {
  final bool hasNextPage;
  final bool hasPrevPage;
  final CursorsModel? cursors;

  const PagingModel({
    required this.hasNextPage,
    required this.hasPrevPage,
    this.cursors,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) {
    return PagingModel(
      hasNextPage: json['has_next_page'] as bool,
      hasPrevPage: json['has_prev_page'] as bool,
      cursors: json['cursors'] != null
          ? CursorsModel.fromJson(json['cursors'])
          : null,
    );
  }

  PagingEntity toEntity() {
    return PagingEntity(
      hasNextPage: hasNextPage,
      hasPrevPage: hasPrevPage,
      cursors: cursors?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [hasNextPage, hasPrevPage, cursors];
}

class CursorsModel extends Equatable {
  final String? next;
  final String? prev;

  const CursorsModel({this.next, this.prev});

  factory CursorsModel.fromJson(Map<String, dynamic> json) {
    return CursorsModel(
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }

  CursorsEntity toEntity() {
    return CursorsEntity(next: next, prev: prev);
  }

  @override
  List<Object?> get props => [next, prev];
}

class LinksModel extends Equatable {
  final String? next;
  final String? prev;

  const LinksModel({this.next, this.prev});

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      next: json['next'] as String?,
      prev: json['prev'] as String?,
    );
  }

  LinksEntity toEntity() {
    return LinksEntity(next: next, prev: prev);
  }

  @override
  List<Object?> get props => [next, prev];
}
