import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';
import 'package:equatable/equatable.dart';

abstract class SeedState extends Equatable {
  const SeedState();

  @override
  List<Object?> get props => [];
}

class SeedInitial extends SeedState {}

class SeedLoading extends SeedState {}

class SeedSuccess extends SeedState {
  final List<SeedEntity> seeds;
  const SeedSuccess(this.seeds);

  @override
  List<Object?> get props => [seeds];
}

class SeedFailure extends SeedState {
  final String message;
  const SeedFailure(this.message);

  @override
  List<Object?> get props => [message];
}
