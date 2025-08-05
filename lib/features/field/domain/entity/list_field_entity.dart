import 'package:equatable/equatable.dart';

class ListFieldEntity extends Equatable {
  final int id;
  final String? name;
  final double? landArea;
  final String? pictureUrl;
  final AddressEntity? address;
  final String? soilType;
  final ActiveCropEntity? activeCrop;

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
  final String? subVillage;
  final String? village;
  final String? district;

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
  final String? seedName;

  const ActiveCropEntity({required this.id, required this.seedName});
  ActiveCropEntity toEntity() {
    return ActiveCropEntity(id: this.id, seedName: this.seedName);
  }

  @override
  List<Object?> get props => [id, seedName];
}
