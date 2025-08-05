import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_state.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/hero/hero_cubit.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/hero/hero_state.dart';
import 'package:clean_architecture_poktani/features/home/presentation/pages/widget/field_card.dart';
import 'package:clean_architecture_poktani/features/home/presentation/pages/widget/hero_card.dart';
import 'package:clean_architecture_poktani/features/profile/domain/entities/user_entity.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/bloc/profile_display_cubit.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/bloc/user_display_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ListFieldCubit()..loadListFields()),
        BlocProvider(create: (context) => BannerHeroCubit()..loadBanners()),
        BlocProvider(
          create: (context) => ProfileDisplayCubit()..displayProfile(),
        ),
      ],
      child: const _HomeScreenBody(),
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ProfileDisplayCubit, ProfileDisplayState>(
                  builder: (context, state) {
                    if (state is UserLoadedState) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: _headerHome(context, state.userEntity),
                      );
                    }
                    if (state is UserLoadingState) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 24),
                _heroSection(context),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lahanku",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Lihat semua",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _cardSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Semua method helper (yang tadinya di HomeScreen) dipindahkan ke sini
  Widget _headerHome(BuildContext context, UserEntity userEntity) {
    String getInitials(String name) {
      List<String> names = name.split(" ");
      String initials = "";
      if (names.isNotEmpty) {
        initials += names[0][0];
        if (names.length > 1) {
          initials += names[names.length - 1][0];
        }
      }
      return initials.toUpperCase();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat Datang,",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
            ),
            Text(
              userEntity.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.green[100],
          child: Text(
            getInitials(userEntity.name),
            style: const TextStyle(
              color: Colors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _heroSection(BuildContext context) {
    return BlocBuilder<BannerHeroCubit, HeroState>(
      builder: (context, state) {
        if (state is HeroLoadingState) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HeroErrorState) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is HeroLoadedState) {
          return Column(
            children: [
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  itemCount: state.banners.length,
                  onPageChanged: (index) {
                    context.read<BannerHeroCubit>().changeBannerPage(index);
                  },
                  itemBuilder: (context, index) {
                    final banner = state.banners[index];
                    return HeroCard(imageUrl: banner.imageUrl);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(state.banners.length, (index) {
                  return _buildIndicatorDot(
                    isActive: index == state.currentIndex,
                  );
                }),
              ),
            ],
          );
        }
        return const SizedBox(
          height: 200,
          child: Center(child: Text("No banners available")),
        );
      },
    );
  }

  Widget _buildIndicatorDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.green : Colors.grey[400],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _cardSection(BuildContext context) {
    // Baris ini sekarang 100% aman
    final scrollController = context.read<ListFieldCubit>().scrollController;
    return BlocBuilder<ListFieldCubit, ListFieldState>(
      builder: (context, state) {
        if (state is ListFieldLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ListFieldError) {
          return Center(child: Text(state.message));
        }

        if (state is ListFieldLoaded) {
          if (state.fields.isEmpty) {
            return const Center(child: Text("Tidak ada lahan tersedia"));
          }
          return SizedBox(
            height: 210,
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: state.hasReachedMax
                  ? state.fields.length
                  : state.fields.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.fields.length) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final field = state.fields[index];
                return FieldCard(field: field);
              },
            ),
          );
        }
        return const Center(child: Text("No fields available"));
      },
    );
  }
}
