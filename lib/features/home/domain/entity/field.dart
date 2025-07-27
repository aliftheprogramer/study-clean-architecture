// Kelas utama untuk menampung seluruh respons API
class ResponseListFieldHomeEntity {
  final String status;
  final String message;
  final List<ItemFieldHomeEntity> data;
  final PagingEntity paging;
  final LinksEntity links;

  ResponseListFieldHomeEntity({
    required this.status,
    required this.message,
    required this.data,
    required this.paging,
    required this.links,
  });
}

//-----------------------------------------------------

// Kelas untuk setiap item lahan di dalam list 'data'
class ItemFieldHomeEntity {
  final int id;
  final String name;
  final double landArea;
  final String? pictureUrl; // Bisa null
  final AddressEntity address;
  final String soilType;
  final ActiveCropEntity? activeCrop; // Bisa null

  ItemFieldHomeEntity({
    required this.id,
    required this.name,
    required this.landArea,
    this.pictureUrl,
    required this.address,
    required this.soilType,
    this.activeCrop,
  });
}

//-----------------------------------------------------

// Kelas untuk objek 'address'
class AddressEntity {
  final String subVillage;
  final String village;
  final String district;

  AddressEntity({
    required this.subVillage,
    required this.village,
    required this.district,
  });
}

//-----------------------------------------------------

// Kelas untuk objek 'active_crop'
class ActiveCropEntity {
  final int id;
  final String seedName;

  ActiveCropEntity({required this.id, required this.seedName});
}

//-----------------------------------------------------

// Kelas untuk objek 'paging'
class PagingEntity {
  final bool hasNextPage;
  final bool hasPrevPage;
  final CursorsEntity cursors;

  PagingEntity({
    required this.hasNextPage,
    required this.hasPrevPage,
    required this.cursors,
  });
}

//-----------------------------------------------------

// Kelas untuk objek 'cursors' di dalam 'paging'
class CursorsEntity {
  final String? next; // Bisa null
  final String? prev; // Bisa null

  CursorsEntity({this.next, this.prev});
}

//-----------------------------------------------------

// Kelas untuk objek 'links'
class LinksEntity {
  final String? next; // Bisa null
  final String? prev; // Bisa null

  LinksEntity({this.next, this.prev});
}
