import 'package:clean_architecture_poktani/features/home/domain/entity/banner.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/hero/hero_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BannerHeroCubit extends Cubit<HeroState> {
  BannerHeroCubit() : super(HeroInitialState());
  final List<BannerPhoto> _dummyBanners = dummyBanners;

  Future<void> loadBanners() async {
    try {
      emit(HeroLoadingState());
      await Future.delayed(Duration(seconds: 1));
      emit(HeroLoadedState(_dummyBanners));
    } catch (e) {
      emit(HeroErrorState("Failed to load banners"));
    }
  }

  void changeBannerPage(int index) {
    if (state is HeroLoadedState) {
      final currentState = state as HeroLoadedState;
      emit(HeroLoadedState(currentState.banners, currentIndex: index));
    }
  }
}
