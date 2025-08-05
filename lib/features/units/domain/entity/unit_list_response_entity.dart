import 'package:equatable/equatable.dart';

class UnitListResponseEntity extends Equatable {
  final String status;
  final String message;
  final List<UnitEntity> data;
  final PagingEntity? paging;
  final LinksEntity? links;

  const UnitListResponseEntity({
    required this.status,
    required this.message,
    required this.data,
    this.paging,
    this.links,
  });

  @override
  List<Object?> get props => [status, message, data, paging, links];
}

class UnitEntity extends Equatable {
  final int id;
  final String name;
  final String symbol;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UnitEntity({
    required this.id,
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, symbol, createdAt, updatedAt];
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
