
import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';
import 'package:equatable/equatable.dart';

class SeedListResponseModel extends Equatable {
  final String status;
  final String message;
  final List<SeedModel> data;
  final PagingModel? paging;
  final LinksModel? links;

  const SeedListResponseModel({
    required this.status,
    required this.message,
    required this.data,
    this.paging,
    this.links,
  });

  factory SeedListResponseModel.fromJson(Map<String, dynamic> json) {
    return SeedListResponseModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)?.map((e) => SeedModel.fromJson(e)).toList() ?? [],
      paging: json['paging'] != null ? PagingModel.fromJson(json['paging']) : null,
      links: json['links'] != null ? LinksModel.fromJson(json['links']) : null,
    );
  }

  SeedListResponseEntity toEntity() {
    return SeedListResponseEntity(
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

class SeedModel extends Equatable {
  final int id;
  final String name;
  final String brand;
  final String variety;
  final double stock;
  final String unit;
  final double price;
  final DateTime createdAt;

  const SeedModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.variety,
    required this.stock,
    required this.unit,
    required this.price,
    required this.createdAt,
  });

  factory SeedModel.fromJson(Map<String, dynamic> json) {
    return SeedModel(
      id: json['id'],
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      variety: json['variety'] ?? '',
      stock: double.tryParse(json['stock'].toString()) ?? 0.0,
      unit: json['unit'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  SeedEntity toEntity() {
    return SeedEntity(
      id: id,
      name: name,
      brand: brand,
      variety: variety,
      stock: stock,
      unit: unit,
      price: price,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, name, brand, variety, stock, unit, price, createdAt];
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
      hasNextPage: json['has_next_page'] ?? false,
      hasPrevPage: json['has_prev_page'] ?? false,
      cursors: json['cursors'] != null ? CursorsModel.fromJson(json['cursors']) : null,
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
      next: json['next'],
      prev: json['prev'],
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
      next: json['next'],
      prev: json['prev'],
    );
  }

  LinksEntity toEntity() {
    return LinksEntity(next: next, prev: prev);
  }

  @override
  List<Object?> get props => [next, prev];
}
