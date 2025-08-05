// Lokasi: lib/data/models/nutrient_response_model.dart

import 'package:clean_architecture_poktani/features/nutriens/domain/entity/entity_response_list_of_nutriens.dart';

class NutrientResponseModel extends NutrientResponseEntity {
  const NutrientResponseModel({
    required super.status,
    required super.message,
    required List<NutrientModel> super.data,
    required PagingModel super.paging,
    required LinksModel super.links,
  });

  factory NutrientResponseModel.fromJson(Map<String, dynamic> json) {
    var listData = json['data'] as List;
    // Pastikan kita mem-parsing list menggunakan NutrientModel.fromJson
    List<NutrientModel> nutrientList =
        listData.map((i) => NutrientModel.fromJson(i)).toList();

    return NutrientResponseModel(
      status: json['status'],
      message: json['message'],
      data: nutrientList,
      paging: PagingModel.fromJson(json['paging']),
      links: LinksModel.fromJson(json['links']),
    );
  }
}

// Model untuk satu item nutrisi, mewarisi NutrientEntity
class NutrientModel extends NutrientEntity {
  const NutrientModel({
    required super.id,
    required super.name,
    required super.category,
    required super.brand,
    required super.price,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NutrientModel.fromJson(Map<String, dynamic> json) {
    return NutrientModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      brand: json['brand'],
      price: double.parse(json['price']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Model untuk paging, mewarisi PagingEntity
class PagingModel extends PagingEntity {
  const PagingModel({
    required super.hasNextPage,
    required super.hasPrevPage,
    required CursorsModel super.cursors,
  });

  factory PagingModel.fromJson(Map<String, dynamic> json) {
    return PagingModel(
      hasNextPage: json['has_next_page'],
      hasPrevPage: json['has_prev_page'],
      cursors: CursorsModel.fromJson(json['cursors']),
    );
  }
}

// Model untuk cursors, mewarisi CursorsEntity
class CursorsModel extends CursorsEntity {
  const CursorsModel({
    super.next,
    super.prev,
  });

  factory CursorsModel.fromJson(Map<String, dynamic> json) {
    return CursorsModel(
      next: json['next'],
      prev: json['prev'],
    );
  }
}

// Model untuk links, mewarisi LinksEntity
class LinksModel extends LinksEntity {
  const LinksModel({
    super.next,
    super.prev,
  });

  factory LinksModel.fromJson(Map<String, dynamic> json) {
    return LinksModel(
      next: json['next'],
      prev: json['prev'],
    );
  }
}