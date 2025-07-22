import 'package:clean_architecture_poktani/features/home/presentation/pages/home_screen.dart';
import 'package:clean_architecture_poktani/features/main/presentation/bloc/navigation_cubit.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PagesScreen extends StatelessWidget {
  PagesScreen({super.key});

  final List<Widget> _pages = [
    HomeScreen(),
    Center(child: Text("Semai")),
    Center(child: Text("Lahan")),
    Center(child: Text("Panen")),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationCubit(),
      child: BlocBuilder<NavigationCubit, NavBarState>(
        builder: (context, state) {
          NavigationCubit cubit = context.read<NavigationCubit>();
          return Scaffold(
            body: SafeArea(child: _pages[cubit.currentIndex]),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.home),
                  label: "Beranda",
                ),
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.sprout),
                  label: "Semai",
                ),
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.map),
                  label: "Lahan",
                ),
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.wheat),
                  label: "Panen",
                ),
                BottomNavigationBarItem(
                  icon: Icon(LucideIcons.userCircle),
                  label: "Profile",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
