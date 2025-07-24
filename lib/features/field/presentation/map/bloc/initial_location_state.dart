import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class InitialLocationState extends Equatable {
  const InitialLocationState();

  @override
  List<Object?> get props => [];
}

class InitialLocationLoading extends InitialLocationState {}

class InitialLocationLoaded extends InitialLocationState {
  final LatLng initialLocation;
  const InitialLocationLoaded(this.initialLocation);

  @override
  List<Object?> get props => [initialLocation];
}
