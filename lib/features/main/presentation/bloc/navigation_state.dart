part of 'navigation_cubit.dart';

@immutable
sealed class NavBarState {}

final class NavBarInitialState extends NavBarState {}

final class IndexChanged extends NavBarState {}
