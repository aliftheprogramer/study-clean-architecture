// lib/features/field/presentation/cubit/map_state.dart

import 'package:equatable/equatable.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/field/response_address_detail_entity.dart';
import 'package:latlong2/latlong.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final LatLng selectedLocation;
  final AddressDetailEntity address;

  const MapLoaded({required this.selectedLocation, required this.address});

  @override
  List<Object?> get props => [selectedLocation, address];
}

class MapError extends MapState {
  final String message;

  const MapError(this.message);

  @override
  List<Object> get props => [message];
}
