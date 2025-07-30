import 'package:clean_architecture_poktani/features/units/domain/entity/unit_list_response_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UnitState extends Equatable {
  const UnitState();

  @override
  List<Object?> get props => [];
}

class UnitInitial extends UnitState {}

class UnitLoading extends UnitState {}

class UnitSuccess extends UnitState {
  final List<UnitEntity> units;
  const UnitSuccess(this.units);

  @override
  List<Object?> get props => [units];
}

class UnitFailure extends UnitState {
  final String message;
  const UnitFailure(this.message);

  @override
  List<Object?> get props => [message];
}
