// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_cast
import 'dart:convert';

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

  // Metode toMap dan toJson tidak perlu diubah jika Anda hanya melakukan deserialization (fromMap/fromJson)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'owner': owner.toMap(),
      'land_area': landArea,
      'picture_url': pictureUrl,
      'address': address.toMap(),
      'coordinates': coordinates.toMap(),
      'soil_type': soilType,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'active_crop': activeCrop?.toMap(),
    };
  }

  // DIUBAH: Menggunakan kunci snake_case agar cocok dengan JSON
  factory FieldDetailEntity.fromMap(Map<String, dynamic> map) {
    return FieldDetailEntity(
      id: map['id'] as int,
      name: map['name'] as String,
      owner: OwnerEntity.fromMap(map['owner'] as Map<String, dynamic>),
      landArea: map['land_area'] as int, // <-- DIUBAH
      pictureUrl: map['picture_url'] != null
          ? map['picture_url'] as String
          : null, // <-- DIUBAH
      address: AddressEntity.fromMap(map['address'] as Map<String, dynamic>),
      coordinates: CoordinatesEntity.fromMap(
        map['coordinates'] as Map<String, dynamic>,
      ),
      soilType: map['soil_type'] as String, // <-- DIUBAH
      createdAt: map['created_at'] as String, // <-- DIUBAH
      updatedAt: map['updated_at'] as String, // <-- DIUBAH
      activeCrop:
          map['active_crop'] !=
              null // <-- DIUBAH
          ? ActiveCropDetailEntity.fromMap(
              map['active_crop'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FieldDetailEntity.fromJson(String source) =>
      FieldDetailEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

// Objek 'owner'
class OwnerEntity {
  final int id;
  final String name;

  const OwnerEntity({required this.id, required this.name});
  Map<String, dynamic> toMap() => {'id': id, 'name': name};
  factory OwnerEntity.fromMap(Map<String, dynamic> map) {
    return OwnerEntity(id: map['id'] as int, name: map['name'] as String);
  }
  String toJson() => json.encode(toMap());
  factory OwnerEntity.fromJson(String source) =>
      OwnerEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

// Objek 'active_crop' yang berisi detail tanaman yang sedang aktif
class ActiveCropDetailEntity {
  final int id;
  final String plantingDate;
  final SeedEntity seed;
  final String coordinatorName;
  // Tandai sebagai nullable
  final List<FertilizerUsageEntity>? fertilizersUsed;
  final List<PesticideUsageEntity>? pesticidesUsed;

  const ActiveCropDetailEntity({
    required this.id,
    required this.plantingDate,
    required this.seed,
    required this.coordinatorName,
    // Hapus 'required' karena sudah boleh null
    this.fertilizersUsed,
    this.pesticidesUsed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'planting_date': plantingDate,
      'seed': seed.toMap(),
      'coordinator_name': coordinatorName,
      'fertilizers_used': fertilizersUsed?.map((x) => x.toMap()).toList(),
      'pesticides_used': pesticidesUsed?.map((x) => x.toMap()).toList(),
    };
  }

  factory ActiveCropDetailEntity.fromMap(Map<String, dynamic> map) {
    return ActiveCropDetailEntity(
      id: map['id'] as int,
      plantingDate: map['planting_date'] as String,
      seed: SeedEntity.fromMap(map['seed'] as Map<String, dynamic>),
      coordinatorName: map['coordinator_name'] as String,

      // DIUBAH: Tambahkan pengecekan null sebelum parsing list
      fertilizersUsed: map['fertilizers_used'] != null
          ? List<FertilizerUsageEntity>.from(
              (map['fertilizers_used'] as List).map<FertilizerUsageEntity>(
                (x) => FertilizerUsageEntity.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null, // Jika null, kembalikan null
      // DIUBAH: Lakukan hal yang sama untuk pesticides
      pesticidesUsed: map['pesticides_used'] != null
          ? List<PesticideUsageEntity>.from(
              (map['pesticides_used'] as List).map<PesticideUsageEntity>(
                (x) => PesticideUsageEntity.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null, // Jika null, kembalikan null
    );
  }

  String toJson() => json.encode(toMap());
  factory ActiveCropDetailEntity.fromJson(String source) =>
      ActiveCropDetailEntity.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

// Objek di dalam array 'fertilizers_used'
class FertilizerUsageEntity {
  final String applicationDate;
  final String name;
  final num
  quantity; // <-- DIUBAH ke num agar lebih fleksibel (bisa int/double)
  final String unit;

  const FertilizerUsageEntity({
    required this.applicationDate,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'application_date': applicationDate,
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory FertilizerUsageEntity.fromMap(Map<String, dynamic> map) {
    return FertilizerUsageEntity(
      applicationDate: map['application_date'] as String, // <-- DIUBAH
      name: map['name'] as String,
      quantity: map['quantity'] as num, // <-- DIUBAH
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory FertilizerUsageEntity.fromJson(String source) =>
      FertilizerUsageEntity.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

// Objek di dalam array 'pesticides_used'
class PesticideUsageEntity {
  final String applicationDate;
  final String name;
  final num quantity; // <-- DIUBAH ke num
  final String unit;

  const PesticideUsageEntity({
    required this.applicationDate,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'application_date': applicationDate,
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory PesticideUsageEntity.fromMap(Map<String, dynamic> map) {
    return PesticideUsageEntity(
      applicationDate: map['application_date'] as String, // <-- DIUBAH
      name: map['name'] as String,
      quantity: map['quantity'] as num, // <-- DIUBAH
      unit: map['unit'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory PesticideUsageEntity.fromJson(String source) =>
      PesticideUsageEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

// -- Kelas-kelas di bawah ini juga disesuaikan untuk konsistensi --

class AddressEntity {
  final String subVillage;
  final String village;
  final String district;

  const AddressEntity({
    required this.subVillage,
    required this.village,
    required this.district,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sub_village': subVillage,
      'village': village,
      'district': district,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    return AddressEntity(
      subVillage: map['sub_village'] as String, // <-- DIUBAH
      village: map['village'] as String,
      district: map['district'] as String,
    );
  }

  String toFullString() => '$subVillage, $village, $district';
}

class CoordinatesEntity {
  final String latitude;
  final String longitude;

  const CoordinatesEntity({required this.latitude, required this.longitude});
  Map<String, dynamic> toMap() => {
    'latitude': latitude,
    'longitude': longitude,
  };
  factory CoordinatesEntity.fromMap(Map<String, dynamic> map) {
    return CoordinatesEntity(
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
    );
  }
}

class SeedEntity {
  final String name;
  final String variety;

  const SeedEntity({required this.name, required this.variety});
  Map<String, dynamic> toMap() => {'name': name, 'variety': variety};
  factory SeedEntity.fromMap(Map<String, dynamic> map) {
    return SeedEntity(
      name: map['name'] as String,
      variety: map['variety'] as String,
    );
  }
}
