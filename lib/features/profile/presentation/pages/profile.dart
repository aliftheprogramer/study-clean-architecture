import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state_cubit.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/welcome.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_submit_auth_button_final.dart';
import 'package:clean_architecture_poktani/features/profile/domain/entities/user_entity.dart';
import 'package:clean_architecture_poktani/features/profile/domain/usecase/logout.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/bloc/profile_display_cubit.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/bloc/user_display_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileDisplayCubit()..displayProfile(),
          ),
          BlocProvider(create: (context) => ButtonStateCubit()),
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Logout successful"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const WelcomePage()),
              );
            }
            if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is ButtonLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Logging out..."),
                  backgroundColor: Colors.blue,
                ),
              );
            }
          },
          child: BlocBuilder<ProfileDisplayCubit, ProfileDisplayState>(
            builder: (context, state) {
              if (state is UserLoadingState) {
                return const CircularProgressIndicator();
              }
              if (state is UserLoadedState) {
                return _buildBody(context, state.userEntity);
              }
              if (state is UserloadFailure) {
                return Center(
                  child: Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }
              return const Center(child: Text("Unexpected state"));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserEntity userEntity) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppBar(title: Text("Profile"), backgroundColor: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "User Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Placeholder for user information
            Text("Name: ${userEntity.name}"),
            Text("Email: ${userEntity.email}"),
            Text("Phone: ${userEntity.phone_number}"),
            const SizedBox(height: 20),
            Text("role: ${userEntity.role}"),
            Text("address: ${userEntity.address}"),

            const SizedBox(height: 20),
            CustomSubmitAuthButtonFinal(
              label: 'Logout',
              onPressed: () {
                context.read<ButtonStateCubit>().execute(
                  usecase: sl<LogoutUseCase>(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
