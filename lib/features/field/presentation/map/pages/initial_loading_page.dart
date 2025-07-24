import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/initial_location_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/initial_location_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/pages/widget/map_picker_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialLoadingPage extends StatelessWidget {
  const InitialLoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 1. Buat Cubit dan langsung panggil method-nya
      create: (context) => InitialLocationCubit()..fetchInitialLocation(),
      child: BlocListener<InitialLocationCubit, InitialLocationState>(
        // 2. Listener akan "mendengar" perubahan state
        listener: (context, state) {
          // Jika state adalah Loaded, lakukan navigasi
          if (state is InitialLocationLoaded) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MapPickerPage(initialLocation: state.initialLocation),
              ),
            );
          }
        },
        // 3. UI yang ditampilkan saat Cubit bekerja
        child: const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Mencari lokasi Anda...'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
