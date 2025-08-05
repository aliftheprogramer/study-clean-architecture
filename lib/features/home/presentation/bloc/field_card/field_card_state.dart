import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';

import 'package:equatable/equatable.dart';

abstract class FieldCardState extends Equatable {
  const FieldCardState();

  @override
  List<Object?> get props => [];
}

class FieldInitialState extends FieldCardState {}

class FieldLoadingState extends FieldCardState {}

class FieldLoadedState extends FieldCardState {
  final List<ListFieldEntity> fields;
  final bool hasReachedMax;

  const FieldLoadedState(this.fields, {this.hasReachedMax = false});

  FieldLoadedState copyWith({
    List<ListFieldEntity>? fields,
    bool? hasReachedMax,
  }) {
    return FieldLoadedState(
      fields ?? this.fields,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
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
