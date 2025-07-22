import 'package:clean_architecture_poktani/features/home/presentation/bloc/field_card/field_card_cubit.dart';
import 'package:clean_architecture_poktani/features/home/presentation/bloc/field_card/field_card_state.dart';
import 'package:clean_architecture_poktani/features/home/presentation/pages/widget/field_card.dart';
import 'package:clean_architecture_poktani/features/home/presentation/pages/widget/hero_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String userName = "John Doe";
  static const List<String> heroImages = [
    'assets/banner.png',
    'assets/banner.png',
    'assets/banner.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FieldCardCubit()..loadFields(),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerHome(context),
            const SizedBox(height: 24),
            _heroSection(context, HeroCard),
            const SizedBox(height: 24),
            _cardSection(context),
          ],
        ),
      ),
    );
  }

  Widget _headerHome(BuildContext context) {
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
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blue,
          child: Text(
            getInitials(userName),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Column(
          children: [
            Text(
              "Selamat Datang",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            // Handle notification button press
          },
        ),
      ],
    );
  }

  Widget _heroSection(BuildContext context, dynamic widget) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: heroImages.length,
        itemBuilder: (context, index) {
          final String imagePath = heroImages[index];
          return HeroCard(imageUrl: imagePath);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _cardSection(BuildContext context) {
    return BlocBuilder<FieldCardCubit, FieldCardState>(
      builder: (context, state) {
        if (state is FieldLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FieldErrorState) {
          return Center(child: Text(state.message));
        }

        if (state is FieldLoadedState) {
          return SizedBox(
            height: 210, // Beri tinggi agar ListView tidak error
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.fields.length,
              itemBuilder: (context, index) {
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
