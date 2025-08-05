import 'package:equatable/equatable.dart';

// Kelas utama yang merepresentasikan seluruh respons
class NutrientResponseEntity extends Equatable {
  final String status;
  final String message;
  final List<NutrientEntity> data;
  final PagingEntity paging;
  final LinksEntity links;

  const NutrientResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.paging,
    required this.links,
  });

  // Factory constructor untuk membuat instance dari JSON Map
  factory NutrientResponseEntity.fromJson(Map<String, dynamic> json) {
    var listData = json['data'] as List;
    List<NutrientEntity> nutrientList =
        listData.map((i) => NutrientEntity.fromJson(i)).toList();

    return NutrientResponseEntity(
      status: json['status'],
      message: json['message'],
      data: nutrientList,
      paging: PagingEntity.fromJson(json['paging']),
      links: LinksEntity.fromJson(json['links']),
    );
  }

  @override
  List<Object?> get props => [status, message, data, paging, links];
}

// Entitas untuk satu item dalam array 'data'
class NutrientEntity extends Equatable {
  final int id;
  final String name;
  final String category;
  final String brand;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NutrientEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor untuk membuat instance dari JSON Map
  factory NutrientEntity.fromJson(Map<String, dynamic> json) {
    return NutrientEntity(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      brand: json['brand'],
      price: double.parse(json['price']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  List<Object?> get props => [id, name, category, brand, price, createdAt, updatedAt];
}

// Entitas untuk objek 'paging'
class PagingEntity extends Equatable {
  final bool hasNextPage;
  final bool hasPrevPage;
  final CursorsEntity cursors;

  const PagingEntity({
    required this.hasNextPage,
    required this.hasPrevPage,
    required this.cursors,
  });

  factory PagingEntity.fromJson(Map<String, dynamic> json) {
    return PagingEntity(
      hasNextPage: json['has_next_page'],
      hasPrevPage: json['has_prev_page'],
      cursors: CursorsEntity.fromJson(json['cursors']),
    );
  }

  @override
  List<Object?> get props => [hasNextPage, hasPrevPage, cursors];
}

// Entitas untuk objek 'cursors'
class CursorsEntity extends Equatable {
  final String? next;
  final String? prev;

  const CursorsEntity({this.next, this.prev});

  factory CursorsEntity.fromJson(Map<String, dynamic> json) {
    return CursorsEntity(
      next: json['next'],
      prev: json['prev'],
    );
  }

  @override
  List<Object?> get props => [next, prev];
}

// Entitas untuk objek 'links'
class LinksEntity extends Equatable {
  final String? next;
  final String? prev;

  const LinksEntity({this.next, this.prev});

  factory LinksEntity.fromJson(Map<String, dynamic> json) {
    return LinksEntity(
      next: json['next'],
      prev: json['prev'],
    );
  }

  @override
  List<Object?> get props => [next, prev];
}