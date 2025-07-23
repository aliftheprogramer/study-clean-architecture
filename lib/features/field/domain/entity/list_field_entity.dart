import 'package:equatable/equatable.dart';

class ListFieldEntity extends Equatable {
  final int id;
  final String name;
  final int landArea;
  final String pictureUrl;
  final AddressEntity address;
  final String soilType;
  final ActiveCropEntity activeCrop;

  const ListFieldEntity({
    required this.id,
    required this.name,
    required this.landArea,
    required this.pictureUrl,
    required this.address,
    required this.soilType,
    required this.activeCrop,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    landArea,
    pictureUrl,
    address,
    soilType,
    activeCrop,
  ];
}

class AddressEntity extends Equatable {
  final String subVillage;
  final String village;
  final String district;

  const AddressEntity({
    required this.subVillage,
    required this.village,
    required this.district,
  });

  @override
  List<Object?> get props => [subVillage, village, district];
}

class ActiveCropEntity extends Equatable {
  final int id;
  final String seedName;

  const ActiveCropEntity({required this.id, required this.seedName});

  @override
  List<Object?> get props => [id, seedName];
}

// final List<ListFieldEntity> dummyListFields = [
//   ListFieldEntity(
//     id: 28,
//     name: "Sawah Subur Jaya",
//     landArea: 100,
//     pictureUrl: "assets/placeholder.png", // Contoh dengan gambar
//     address: AddressEntity(
//       subVillage: "Panembahan",
//       village: "Yogyakarta",
//       district: "Kraton",
//     ),
//     soilType: "Podsolik",
//     activeCrop: ActiveCropEntity(id: 5, seedName: "Padi Sawah"),
//   ),
//   ListFieldEntity(
//     id: 30,
//     name: "Kebun Makmur Sentosa",
//     landArea: 150,
//     pictureUrl: "assets/placeholder.png", // Contoh tanpa gambar
//     address: AddressEntity(
//       subVillage: "Caturtunggal",
//       village: "Sleman",
//       district: "Depok",
//     ),
//     soilType: "Latosol",
//     activeCrop: ActiveCropEntity(id: 12, seedName: "Jagung Manis"),
//   ),
//   ListFieldEntity(
//     id: 45,
//     name: "Ladang Hijau Lestari",
//     landArea: 75,
//     pictureUrl: "assets/placeholder.png", // Contoh dengan gambar lain
//     address: AddressEntity(
//       subVillage: "Wirobrajan",
//       village: "Yogyakarta",
//       district: "Wirobrajan",
//     ),
//     soilType: "Andosol",
//     activeCrop: ActiveCropEntity(id: 8, seedName: "Cabai Rawit"),
//   ),
// ];
