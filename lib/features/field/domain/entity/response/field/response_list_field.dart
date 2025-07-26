import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:equatable/equatable.dart';

// Entity utama yang membungkus semua data sukses
class FieldResponseEntity extends Equatable {
  final List<ListFieldEntity> fields;
  final PagingEntity? paging;
  final LinksEntity? links;

  const FieldResponseEntity({required this.fields, this.paging, this.links});

  @override
  List<Object?> get props => [fields, paging, links];
}

// Entity untuk Paging
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
  List<Object?> get props => [hasNextPage, hasPrevPage];
}

// Entity untuk Links
class LinksEntity extends Equatable {
  final String? next;
  final String? prev;

  const LinksEntity({this.next, this.prev});

  @override
  List<Object?> get props => [next, prev];
}

class CursorsEntity extends Equatable {
  final String? next;
  final String? prev;

  const CursorsEntity({this.next, this.prev});

  @override
  List<Object?> get props => [next, prev];
}
