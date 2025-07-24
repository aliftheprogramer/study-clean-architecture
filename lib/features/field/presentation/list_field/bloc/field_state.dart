import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:equatable/equatable.dart';

abstract class ListFieldState extends Equatable {
  const ListFieldState();

  @override
  List<Object?> get props => [];
}

class ListFieldInitial extends ListFieldState {}

class ListFieldLoading extends ListFieldState {}

class ListFieldLoaded extends ListFieldState {
  final List<ListFieldEntity> fields;
  final bool hasReachedMax;

  const ListFieldLoaded({required this.fields, required this.hasReachedMax});

  ListFieldLoaded copyWith({
    List<ListFieldEntity>? fields,
    bool? hasReachedMax,
  }) {
    return ListFieldLoaded(
      fields: fields ?? this.fields,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [fields, hasReachedMax];
}

class ListFieldError extends ListFieldState {
  final String message;

  const ListFieldError(this.message);

  @override
  List<Object?> get props => [message];
}
