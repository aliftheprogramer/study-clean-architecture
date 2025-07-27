import 'package:clean_architecture_poktani/features/home/domain/entity/field.dart';
import 'package:equatable/equatable.dart';

abstract class FieldCardState extends Equatable {
  const FieldCardState();

  @override
  List<Object?> get props => [];
}

class FieldInitialState extends FieldCardState {}

class FieldLoadingState extends FieldCardState {}

class FieldLoadedState extends FieldCardState {
  final List<ItemFieldHomeEntity> fields;

  const FieldLoadedState(this.fields);

  FieldLoadedState copyWith({List<ItemFieldHomeEntity>? fields}) {
    return FieldLoadedState(fields ?? this.fields);
  }

  @override
  List<Object?> get props => [fields];
}

class FieldErrorState extends FieldCardState {
  final String message;

  const FieldErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
