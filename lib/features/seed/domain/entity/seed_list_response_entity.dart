import 'package:equatable/equatable.dart';

class SeedListResponseEntity extends Equatable {
  final String status;
  final String message;
  final List<SeedEntity> data;
  final PagingEntity? paging;
  final LinksEntity? links;

  const SeedListResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    this.paging,
    this.links,
  });

  @override
  List<Object?> get props => [status, message, data, paging, links];
}

class SeedEntity extends Equatable {
  final int id;
  final String name;
  final String brand;
  final String variety;
  final double stock;
  final String unit;
  final double price;
  final DateTime createdAt;

  const SeedEntity({
    required this.id,
    required this.name,
    required this.brand,
    required this.variety,
    required this.stock,
    required this.unit,
    required this.price,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    brand,
    variety,
    stock,
    unit,
    price,
    createdAt,
  ];
}

class PagingEntity extends Equatable {
  final bool hasNextPage;
  final bool hasPrevPage;
  final CursorsEntity? cursors;

  const PagingEntity({
    required this.hasNextPage,
    required this.hasPrevPage,
    this.cursors,
  });

  @override
  List<Object?> get props => [hasNextPage, hasPrevPage, cursors];
}

class CursorsEntity extends Equatable {
  final String? next;
  final String? prev;

  const CursorsEntity({this.next, this.prev});

  @override
  List<Object?> get props => [next, prev];
}

class LinksEntity extends Equatable {
  final String? next;
  final String? prev;

  const LinksEntity({this.next, this.prev});

  @override
  List<Object?> get props => [next, prev];
}
