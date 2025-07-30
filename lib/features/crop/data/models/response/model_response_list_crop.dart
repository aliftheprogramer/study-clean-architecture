import 'dart:convert';

// Fungsi helper untuk mem-parsing JSON String menjadi objek ModelResponseListCrop
ModelResponseListCrop apiResponseFromJson(String str) =>
    ModelResponseListCrop.fromJson(json.decode(str));

// 1. Class Utama untuk seluruh respons API
class ModelResponseListCrop {
  final String status;
  final String message;
  final List<CropModel> data;
  final Paging paging;
  final Links links;

  ModelResponseListCrop({
    required this.status,
    required this.message,
    required this.data,
    required this.paging,
    required this.links,
  });

  factory ModelResponseListCrop.fromJson(Map<String, dynamic> json) =>
      ModelResponseListCrop(
        status: json["status"],
        message: json["message"],
        // Mengubah list JSON menjadi List<CropModel>
        data: List<CropModel>.from(
          json["data"].map((x) => CropModel.fromJson(x)),
        ),
        paging: Paging.fromJson(json["paging"]),
        links: Links.fromJson(json["links"]),
      );

  factory ModelResponseListCrop.fromMap(Map<String, dynamic> map) {
    return ModelResponseListCrop(
      status: map["status"],
      message: map["message"],
      data: List<CropModel>.from(map["data"].map((x) => CropModel.fromJson(x))),
      paging: Paging.fromJson(map["paging"]),
      links: Links.fromJson(map["links"]),
    );
  }
}

// 2. Class untuk setiap item di dalam list "data"
class CropModel {
  final int id;
  final int fieldId;
  final int nurseryId;
  final String plantingDate;
  final String plantQuantity;
  final String status;
  final Seed seed;
  final Coordinator coordinator;
  final DateTime createdAt;

  CropModel({
    required this.id,
    required this.fieldId,
    required this.nurseryId,
    required this.plantingDate,
    required this.plantQuantity,
    required this.status,
    required this.seed,
    required this.coordinator,
    required this.createdAt,
  });

  factory CropModel.fromJson(Map<String, dynamic> json) => CropModel(
    id: json["id"],
    fieldId: json["field_id"],
    nurseryId: json["nursery_id"],
    plantingDate: json["planting_date"],
    plantQuantity: json["plant_quantity"],
    status: json["status"],
    seed: Seed.fromJson(json["seed"]),
    coordinator: Coordinator.fromJson(json["coordinator"]),
    createdAt: DateTime.parse(json["created_at"]),
  );
}

// 3. Class untuk objek "coordinator"
class Coordinator {
  final int id;
  final String name;

  Coordinator({required this.id, required this.name});

  factory Coordinator.fromJson(Map<String, dynamic> json) =>
      Coordinator(id: json["id"], name: json["name"]);
}

// 4. Class untuk objek "seed"
class Seed {
  final int id;
  final String name;
  final String variety;
  final String unit;

  Seed({
    required this.id,
    required this.name,
    required this.variety,
    required this.unit,
  });

  factory Seed.fromJson(Map<String, dynamic> json) => Seed(
    id: json["id"],
    name: json["name"],
    variety: json["variety"],
    unit: json["unit"],
  );
}

// 5. Class untuk objek "links"
class Links {
  final String? next;
  final String? prev;

  Links({this.next, this.prev});

  factory Links.fromJson(Map<String, dynamic> json) =>
      Links(next: json["next"], prev: json["prev"]);
}

// 6. Class untuk objek "paging"
class Paging {
  final bool hasNextPage;
  final bool hasPrevPage;
  final Cursors cursors;

  Paging({
    required this.hasNextPage,
    required this.hasPrevPage,
    required this.cursors,
  });

  factory Paging.fromJson(Map<String, dynamic> json) => Paging(
    hasNextPage: json["has_next_page"],
    hasPrevPage: json["has_prev_page"],
    cursors: Cursors.fromJson(json["cursors"]),
  );
}

// 7. Class untuk objek "cursors" di dalam Paging
class Cursors {
  final dynamic next; // Bisa String atau null
  final dynamic prev; // Bisa String atau null

  Cursors({this.next, this.prev});

  factory Cursors.fromJson(Map<String, dynamic> json) =>
      Cursors(next: json["next"], prev: json["prev"]);
}
