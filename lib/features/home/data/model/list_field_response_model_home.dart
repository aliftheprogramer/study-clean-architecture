import 'dart:convert';

// Ganti dengan path ke file entity Anda yang sebenarnya
import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';

//=====================================================
// MODEL UTAMA
//=====================================================

class ResponseListFieldHomeModel extends ResponseListFieldHomeEntity {
  ResponseListFieldHomeModel({
    required super.status,
    required super.message,
    required super.data,
    required super.paging,
    required super.links,
  });

  factory ResponseListFieldHomeModel.fromMap(Map<String, dynamic> map) {
    return ResponseListFieldHomeModel(
      status: map['status'],
      message: map['message'],
      data: List<ItemFieldHomeEntity>.from(
        map['data']?.map((x) => ItemFieldHomeModel.fromMap(x)) ?? [],
      ),
      paging: PagingModel.fromMap(map['paging']),
      links: LinksModel.fromMap(map['links']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': List<dynamic>.from(
        data.map((x) => (x as ItemFieldHomeModel).toMap()),
      ),
      'paging': (paging as PagingModel).toMap(),
      'links': (links as LinksModel).toMap(),
    };
  }

  ResponseListFieldHomeEntity toEntity() {
    return ResponseListFieldHomeEntity(
      status: status,
      message: message,
      data: List<ItemFieldHomeEntity>.from(
        data.map((x) => (x as ItemFieldHomeModel).toEntity()),
      ),
      paging: (paging as PagingModel).toEntity(),
      links: (links as LinksModel).toEntity(),
    );
  }
}

//=====================================================
// MODEL ITEM
//=====================================================

class ItemFieldHomeModel extends ItemFieldHomeEntity {
  ItemFieldHomeModel({
    required super.id,
    required super.name,
    required super.landArea,
    super.pictureUrl,
    required super.address,
    required super.soilType,
    super.activeCrop,
  });

  factory ItemFieldHomeModel.fromMap(Map<String, dynamic> map) {
    return ItemFieldHomeModel(
      id: map['id'],
      name: map['name'],
      landArea: (map['land_area'] as num).toDouble(),
      pictureUrl: map['picture_url'],
      address: AddressModel.fromMap(map['address']),
      soilType: map['soil_type'],
      activeCrop: map['active_crop'] != null
          ? ActiveCropModel.fromMap(map['active_crop'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'land_area': landArea,
      'picture_url': pictureUrl,
      'address': (address as AddressModel).toMap(),
      'soil_type': soilType,
      'active_crop': (activeCrop as ActiveCropModel?)?.toMap(),
    };
  }

  ItemFieldHomeEntity toEntity() {
    return ItemFieldHomeEntity(
      id: id,
      name: name,
      landArea: landArea,
      pictureUrl: pictureUrl,
      address: (address as AddressModel).toEntity(),
      soilType: soilType,
      activeCrop: (activeCrop as ActiveCropModel?)?.toEntity(),
    );
  }
}

//=====================================================
// MODEL PENDUKUNG (Address, ActiveCrop, Paging, dll.)
//=====================================================

class AddressModel extends AddressEntity {
  AddressModel({
    required super.subVillage,
    required super.village,
    required super.district,
  });

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      subVillage: map['sub_village'],
      village: map['village'],
      district: map['district'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sub_village': subVillage,
      'village': village,
      'district': district,
    };
  }

  AddressEntity toEntity() {
    return AddressEntity(
      subVillage: subVillage,
      village: village,
      district: district,
    );
  }
}

class ActiveCropModel extends ActiveCropEntity {
  ActiveCropModel({required super.id, required super.seedName});

  factory ActiveCropModel.fromMap(Map<String, dynamic> map) {
    return ActiveCropModel(id: map['id'], seedName: map['seed_name']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'seed_name': seedName};
  }

  // FUNGSI toEntity YANG DITAMBAHKAN
  ActiveCropEntity toEntity() {
    return ActiveCropEntity(id: id, seedName: seedName);
  }
}

class PagingModel extends PagingEntity {
  PagingModel({
    required super.hasNextPage,
    required super.hasPrevPage,
    required super.cursors,
  });

  factory PagingModel.fromMap(Map<String, dynamic> map) {
    return PagingModel(
      hasNextPage: map['has_next_page'],
      hasPrevPage: map['has_prev_page'],
      cursors: CursorsModel.fromMap(map['cursors']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'has_next_page': hasNextPage,
      'has_prev_page': hasPrevPage,
      'cursors': (cursors as CursorsModel).toMap(),
    };
  }

  PagingEntity toEntity() {
    return PagingEntity(
      hasNextPage: hasNextPage,
      hasPrevPage: hasPrevPage,
      cursors: (cursors as CursorsModel).toEntity(),
    );
  }
}

class CursorsModel extends CursorsEntity {
  CursorsModel({super.next, super.prev});

  factory CursorsModel.fromMap(Map<String, dynamic> map) {
    return CursorsModel(next: map['next'], prev: map['prev']);
  }

  Map<String, dynamic> toMap() {
    return {'next': next, 'prev': prev};
  }

  // FUNGSI toEntity YANG DITAMBAHKAN
  CursorsEntity toEntity() {
    return CursorsEntity(next: next, prev: prev);
  }
}

class LinksModel extends LinksEntity {
  LinksModel({super.next, super.prev});

  factory LinksModel.fromMap(Map<String, dynamic> map) {
    return LinksModel(next: map['next'], prev: map['prev']);
  }

  Map<String, dynamic> toMap() {
    return {'next': next, 'prev': prev};
  }

  // FUNGSI toEntity YANG DITAMBAHKAN
  LinksEntity toEntity() {
    return LinksEntity(next: next, prev: prev);
  }
}
