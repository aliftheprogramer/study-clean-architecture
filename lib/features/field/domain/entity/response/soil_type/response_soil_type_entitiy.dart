import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_list_field.dart';
import 'package:equatable/equatable.dart';

class ResponseSoilTypeEntitiy extends Equatable {
  final List<SoilTypeEntitiy>? data;
  final PagingEntity? paging;
  final LinksEntity? links;

  const ResponseSoilTypeEntitiy({this.data, this.paging, this.links});

  @override
  List<Object?> get props => [data, paging, links];
}

class SoilTypeEntitiy extends Equatable {
  final int id;
  final String name;
  final String description;
  final String createdAt;
  final String updatedAt;

  const SoilTypeEntitiy({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, name, description];
}
