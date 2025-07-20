import 'package:clean_architecture_poktani/features/profile/domain/entities/user_entity.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/bloc/profile_display_cubit.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/bloc/user_display_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProfileDisplayCubit()..displayProfile(),
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
          ],
        ),
      ),
    );
  }
}
