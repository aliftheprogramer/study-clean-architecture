import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';
import 'package:equatable/equatable.dart';

abstract class SearchSoilTypeState extends Equatable {
  const SearchSoilTypeState();

  @override
  List<Object?> get props => [];
}

class SearchSoilTypeInitial extends SearchSoilTypeState {}

class SearchSoilTypeLoading extends SearchSoilTypeState {
  final String message;
  const SearchSoilTypeLoading(this.message);
}

class SearchSoilTypeLoaded extends SearchSoilTypeState {
  final List<SoilTypeEntitiy> soilTypes;
  final bool hasReachedMax;

  const SearchSoilTypeLoaded({
    required this.soilTypes,
    required this.hasReachedMax,
  });

  SearchSoilTypeLoaded copyWith({
    List<SoilTypeEntitiy>? soilTypes,
    bool? hasReachedMax,
  }) {
    return SearchSoilTypeLoaded(
      soilTypes: soilTypes ?? this.soilTypes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [soilTypes, hasReachedMax];
}

class SearchSoilTypeError extends SearchSoilTypeState {
  final String message;

  const SearchSoilTypeError(this.message);

  @override
  List<Object?> get props => [message];
}
