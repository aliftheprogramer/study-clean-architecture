import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/add_field_usecase.dart';
import 'package:clean_architecture_poktani/features/field/presentation/add_field/bloc/add_field_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/add_field/bloc/add_field_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/add_field/widget/custom_soil_type_dropdown.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/initial_location_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/initial_location_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/map_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/pages/initial_location_page.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/pages/widget/map_picker_image.dart';
import 'package:clean_architecture_poktani/widget/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class AddFieldPage extends StatelessWidget {
  final TextEditingController _fieldNameController = TextEditingController();
  final TextEditingController _fieldSizeController = TextEditingController();
  final TextEditingController _fieldDusunController = TextEditingController();
  final TextEditingController _fieldDesaController = TextEditingController();
  final TextEditingController _fieldKecamatanController =
      TextEditingController();

  AddFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Lahan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
        centerTitle: true,
        toolbarHeight: 80,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AddFieldCubit(sl<AddFieldUseCase>()),
          ),
        ],
        child: BlocBuilder<AddFieldCubit, AddFieldState>(
          builder: (context, state) {
            LatLng? currentLocation;
            if (state is AddFieldInitial) {
              currentLocation = state.selectedLocation;
              return _bodyFormAddField(context, currentLocation);
            } else if (state is AddFieldLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddFieldSuccess) {
              return const Center(child: Text('Lahan berhasil ditambahkan'));
            } else if (state is AddFieldFailure) {
              return Center(
                child: Text('Gagal menambahkan lahan: ${state.errorMessage}'),
              );
            } else {
              return const SizedBox.shrink(); // Default case
            }
          },
        ),
      ),
    );
  }

  Widget _bodyFormAddField(BuildContext context, LatLng? currentLocation) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormTextField(
                label: 'Nama Lahan',
                keyboardType: TextInputType.text,
                isPassword: false,
                isNumber: false,
                controller: _fieldNameController,
                obsecureText: false,
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomFormTextField(
                      label: 'Luas lahan (m²)',
                      keyboardType: TextInputType.number,
                      isPassword: false,
                      isNumber: true,
                      controller: _fieldSizeController,
                      obsecureText: false,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(child: CustomSoilTypeDropDown()),
                ],
              ),
              const SizedBox(height: 20), // Memberi jarak setelah Row
              // DIHAPUS: Widget Expanded yang menyebabkan error di sini
              CustomFormTextField(
                label: "Dusun",
                keyboardType: TextInputType.text,
                isPassword: false,
                isNumber: false,
                controller: _fieldDusunController,
                obsecureText: false,
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                label: "Desa",
                keyboardType: TextInputType.text,
                isPassword: false,
                isNumber: false,
                controller: _fieldDesaController,
                obsecureText: false,
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                label: "Kecamatan",
                keyboardType: TextInputType.text,
                isPassword: false,
                isNumber: false,
                controller: _fieldKecamatanController,
                obsecureText: false,
              ),
              const SizedBox(height: 20),
              // Panggil InitialLocationPage di sini
              InitialLocationPage(
                selectedLocation: currentLocation,
                onTap: () async {
                  // STEP 1: TENTUKAN LOKASI UNTUK DIBUKA DI PETA
                  LatLng? locationForMap;

                  if (currentLocation != null) {
                    // Jika sudah ada lokasi, pakai lokasi itu.
                    locationForMap = currentLocation;
                  } else {
                    // Jika belum ada, coba dapatkan dari GPS.
                    // Pengecekan 'context.mounted' untuk keamanan async
                    if (!context.mounted) return;
                    final tempLocationCubit = InitialLocationCubit()
                      ..fetchInitialLocation();
                    final initialState = await tempLocationCubit.stream
                        .firstWhere(
                          (s) =>
                              s is InitialLocationLoaded ||
                              s is InitialLocationFailure,
                        );
                    tempLocationCubit.close();

                    if (initialState is InitialLocationLoaded) {
                      locationForMap = initialState.initialLocation;
                    }
                  }

                  // JIKA SETELAH SEMUA USAHA LOKASI TETAP NULL (misal: GPS gagal),
                  // TAMPILKAN PESAN DAN BERHENTI.
                  if (locationForMap == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Gagal mendapatkan lokasi. Pastikan GPS aktif dan coba lagi.',
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    return; // Keluar dari fungsi
                  }

                  // STEP 2: SELALU BUKA PETA DENGAN LOKASI YANG SUDAH DITENTUKAN
                  // Perintah navigasi ini sekarang ada di luar if/else, jadi akan selalu dijalankan.
                  if (!context.mounted) return;
                  final result = await Navigator.push<MapLoaded>(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          MapPickerPage(initialLocation: locationForMap!),
                    ),
                  );

                  // STEP 3: PROSES HASILNYA JIKA ADA
                  if (result != null && context.mounted) {
                    context.read<AddFieldCubit>().updateSelectedLocation(
                      result.selectedLocation,
                    );
                    _fieldDusunController.text = result.address.hamlet ?? '';
                    _fieldDesaController.text = result.address.village ?? '';
                    _fieldKecamatanController.text =
                        result.address.city_district ?? '';
                  }
                },
              ),
              const SizedBox(height: 20),
              // TODO: Tambahkan Tombol Simpan di sini
            ],
          ),
        ),
      ),
    );
  }
}
