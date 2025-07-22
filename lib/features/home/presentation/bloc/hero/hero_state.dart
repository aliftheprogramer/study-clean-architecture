import 'package:flutter/widgets.dart' show Hero, immutable;

@immutable
sealed class HeroState {}

final class HeroInitialState extends HeroState {}

final class HeroLoadingState extends HeroState {}

final class HeroLoadedState extends HeroState {
  final List<Hero> heroes;

  HeroLoadedState(this.heroes);
}
