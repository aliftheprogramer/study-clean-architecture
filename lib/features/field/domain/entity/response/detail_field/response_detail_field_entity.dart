// Kelas utama yang membungkus seluruh respons API
class ResponseFieldDetailEntity {
  final String status;
  final String message;
  final FieldDetailEntity data;

  const ResponseFieldDetailEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}

// Merepresentasikan objek 'data' utama yang berisi detail lahan
class FieldDetailEntity {
  final int id;
  final String name;
  final OwnerEntity owner;
  final int landArea;
  final String? pictureUrl;
  final AddressEntity address;
  final CoordinatesEntity coordinates;
  final String soilType;
  final String createdAt;
  final String updatedAt;
  final ActiveCropDetailEntity? activeCrop;

  const FieldDetailEntity({
    required this.id,
    required this.name,
    required this.owner,
    required this.landArea,
    this.pictureUrl,
    required this.address,
    required this.coordinates,
    required this.soilType,
    required this.createdAt,
    required this.updatedAt,
    this.activeCrop,
  });
}

// Objek 'owner'
class OwnerEntity {
  final int id;
  final String name;

  const OwnerEntity({required this.id, required this.name});
}

// Objek 'active_crop' yang berisi detail tanaman yang sedang aktif
class ActiveCropDetailEntity {
  final int id;
  final String plantingDate;
  final SeedEntity seed;
  final String coordinatorName;
  final List<FertilizerUsageEntity> fertilizersUsed;
  final List<PesticideUsageEntity> pesticidesUsed;

  const ActiveCropDetailEntity({
    required this.id,
    required this.plantingDate,
    required this.seed,
    required this.coordinatorName,
    required this.fertilizersUsed,
    required this.pesticidesUsed,
  });
}

// Objek di dalam array 'fertilizers_used'
class FertilizerUsageEntity {
  final String applicationDate;
  final String name;
  final int quantity;
  final String unit;

  const FertilizerUsageEntity({
    required this.applicationDate,
    required this.name,
    required this.quantity,
    required this.unit,
  });
}

// Objek di dalam array 'pesticides_used'
class PesticideUsageEntity {
  final String applicationDate;
  final String name;
  final int quantity;
  final String unit;

  const PesticideUsageEntity({
    required this.applicationDate,
    required this.name,
    required this.quantity,
    required this.unit,
  });
}

// -- Kelas-kelas ini sama seperti sebelumnya, disertakan lagi untuk kelengkapan --

class AddressEntity {
  final String subVillage;
  final String village;
  final String district;

  const AddressEntity({
    required this.subVillage,
    required this.village,
    required this.district,
  });
}

class CoordinatesEntity {
  final String latitude;
  final String longitude;

  const CoordinatesEntity({required this.latitude, required this.longitude});
}

class SeedEntity {
  final String name;
  final String variety;

  const SeedEntity({required this.name, required this.variety});
}
