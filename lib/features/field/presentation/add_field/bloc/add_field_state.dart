import 'package:clean_architecture_poktani/features/field/data/model/request/request_add_field.dart';
import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart'; // Jangan lupa import LatLng

abstract class AddFieldState extends Equatable {
  const AddFieldState();

  @override
  List<Object?> get props => []; // Ubah menjadi List<Object?>
}

// Tambahkan properti selectedLocation
class AddFieldInitial extends AddFieldState {
  final LatLng? selectedLocation;
  final AddFieldRequestModel fieldRequestModel;

  const AddFieldInitial({
    this.selectedLocation,
    required this.fieldRequestModel,
  });

  @override
  List<Object?> get props => [selectedLocation];
}

class AddFieldLoading extends AddFieldState {}

// Ubah AddFieldSuccess agar tidak error
class AddFieldSuccess extends AddFieldState {
  final String message;

  const AddFieldSuccess({this.message = "Lahan berhasil ditambahkan!"});

  @override
  List<Object> get props => [message];
}

class AddFieldFailure extends AddFieldState {
  final String errorMessage;

  const AddFieldFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
