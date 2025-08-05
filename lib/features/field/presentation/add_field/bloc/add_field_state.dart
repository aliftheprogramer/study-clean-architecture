import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class AddFieldState extends Equatable {
  const AddFieldState();
  @override
  List<Object?> get props => [];
}

class AddFieldInitial extends AddFieldState {
  final String name;
  final double landArea;
  final LatLng? location;
  final String subVillage;
  final String village;
  final String district;
  final int soilTypeId;

  const AddFieldInitial({
    this.name = '',
    this.landArea = 0,
    this.location,
    this.subVillage = '',
    this.village = '',
    this.district = '',
    this.soilTypeId = 0,
  });

  // copyWith untuk update state dengan mudah
  AddFieldInitial copyWith({
    String? name,
    double? landArea, // <-- 1. UBAH INI JADI camelCase
    LatLng? location,
    String? subVillage,
    String? village,
    String? district,
    int? soilTypeId,
  }) {
    return AddFieldInitial(
      name: name ?? this.name,
      landArea: landArea ?? this.landArea, // <-- 2. INI SEKARANG SUDAH BENAR
      location: location ?? this.location,
      subVillage: subVillage ?? this.subVillage,
      village: village ?? this.village,
      district: district ?? this.district,
      soilTypeId: soilTypeId ?? this.soilTypeId,
    );
  }

  @override
  List<Object?> get props => [
    name,
    landArea,
    location,
    subVillage,
    village,
    district,
    soilTypeId,
  ];
}

class AddFieldLoading extends AddFieldState {}

class AddFieldSuccess extends AddFieldState {}

class AddFieldFailure extends AddFieldState {
  final String message;
  const AddFieldFailure(this.message);
  @override
  List<Object> get props => [message];
}
