import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/field_card/field_card_state.dart';
import 'package:equatable/equatable.dart';

abstract class ListFieldState extends Equatable {
  const ListFieldState();

  @override
  List<Object?> get props => [];
}

class ListFieldInitialState extends ListFieldState {}

class ListFieldLoadingState extends ListFieldState {}

class ListFieldLoadedState extends ListFieldState {
  final List<ListFieldEntity> fields;

  const ListFieldLoadedState(this.fields);

  @override
  List<Object?> get props => [fields];
}

class ListFieldErrorState extends ListFieldState {
  final String message;

  const ListFieldErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class ListFieldEmptyState extends ListFieldState {
  final String message;

  const ListFieldEmptyState(this.message);

  @override
  List<Object?> get props => [message];
}
