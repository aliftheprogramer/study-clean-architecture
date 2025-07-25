import 'package:equatable/equatable.dart';

abstract class AddFieldState extends Equatable {
  const AddFieldState();

  @override
  List<Object> get props => [];
}

class AddFieldInitial extends AddFieldState {}

// Kondisi saat data sedang dikirim ke server
class AddFieldLoading extends AddFieldState {}

// Kondisi saat data berhasil ditambahkan
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
