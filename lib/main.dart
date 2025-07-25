import 'package:clean_architecture_poktani/common/bloc/auth/auth_state.dart';
import 'package:clean_architecture_poktani/common/bloc/auth/auth_state_cubit.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/welcome.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/pages/initial_location_page.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/pages/widget/map_picker_image.dart';
import 'package:clean_architecture_poktani/features/main/presentation/pages/pages_screen.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthStateCubit()..appStarted(),
      child: MaterialApp(
        title: 'Poktani App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: BlocBuilder<AuthStateCubit, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              // return ProfilePage();
              return PagesScreen();
            }
            if (state is UnAuthenticated) {
              // return WelcomePage();
              return InitialLocationPage();
            }
            return Container(); // example use for splash screen or loading state
          },
        ),
      ),
    );
  }
}
