// file: features/field/presentation/detail_field/bloc/detail_field_bloc.dart

import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:equatable/equatable.dart';

abstract class DetailFieldState extends Equatable {
  const DetailFieldState();

  @override
  List<Object?> get props => [];
}

class DetailFieldInitial extends DetailFieldState {}

class DetailFieldLoading extends DetailFieldState {}

class DetailFieldLoaded extends DetailFieldState {
  final FieldDetailEntity fieldDetail;

  const DetailFieldLoaded(this.fieldDetail);

  @override
  List<Object?> get props => [fieldDetail];
}

class DetailFieldError extends DetailFieldState {
  final String message;

  const DetailFieldError(this.message);

  @override
  List<Object?> get props => [message];
}
