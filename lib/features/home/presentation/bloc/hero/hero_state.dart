import 'package:clean_architecture_poktani/features/home/domain/entity/banner.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class HeroState extends Equatable {
  const HeroState();

  @override
  List<Object?> get props => [];
}

final class HeroInitialState extends HeroState {}

final class HeroLoadingState extends HeroState {}

final class HeroLoadedState extends HeroState {
  final List<BannerPhoto> banners;
  final int currentIndex;

  const HeroLoadedState(this.banners, {this.currentIndex = 0});

  @override
  List<Object?> get props => [banners, currentIndex];
}

final class HeroErrorState extends HeroState {
  final String errorMessage;

  const HeroErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
