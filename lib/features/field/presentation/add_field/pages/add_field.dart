import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';
import 'package:clean_architecture_poktani/features/field/domain/usecase/add_field_usecase.dart';
import 'package:clean_architecture_poktani/features/field/presentation/add_field/bloc/add_field_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/add_field/bloc/add_field_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/get_soil_type/pages/search_soil_type_page.dart';
import 'package:clean_architecture_poktani/features/map/presentation/bloc/initial_location_cubit.dart';
import 'package:clean_architecture_poktani/features/map/presentation/bloc/initial_location_state.dart';
import 'package:clean_architecture_poktani/features/map/presentation/bloc/map_state.dart';
import 'package:clean_architecture_poktani/features/map/presentation/pages/initial_location_page.dart';
import 'package:clean_architecture_poktani/features/map/presentation/pages/widget/map_picker_image.dart';
import 'package:clean_architecture_poktani/widget/custom_button_fleld.dart';
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
  final TextEditingController _fieldSoilTypeController =
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
        child: BlocConsumer<AddFieldCubit, AddFieldState>(
          builder: (context, state) {
            LatLng? currentLocation;
            if (state is AddFieldInitial) {
              // ignore: unnecessary_type_check
              final currentState = state is AddFieldInitial
                  ? state
                  : const AddFieldInitial();
              currentLocation = state.location;
              final bool isFormValid =
                  currentState.name.isNotEmpty &&
                  currentState.landArea > 0 &&
                  currentState.soilTypeId != 0;
              return _bodyFormAddField(context, currentLocation, isFormValid);
            } else if (state is AddFieldLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddFieldSuccess) {
              return const Center(child: Text('Lahan berhasil ditambahkan'));
            } else if (state is AddFieldFailure) {
              return Center(
                child: Text('Gagal menambahkan lahan: ${state.message}'),
              );
            } else {
              return const SizedBox.shrink(); // Default case
            }
          },
          listener: (BuildContext context, AddFieldState state) {
            if (state is AddFieldSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Lahan berhasil ditambahkan'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            } else if (state is AddFieldFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Gagal menambahkan lahan: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _bodyFormAddField(
    BuildContext context,
    LatLng? currentLocation,
    bool isFormValid,
  ) {
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
                onChanged: (value) =>
                    context.read<AddFieldCubit>().nameChanged(value),
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
                      onChanged: (value) {
                        final landArea = double.tryParse(value) ?? 0;
                        context.read<AddFieldCubit>().landAreaChanged(landArea);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomFormTextField(
                      label: "Jenis Tanah",
                      isPassword: false,
                      isNumber: false,
                      controller: _fieldSoilTypeController,
                      obsecureText: false,
                      onTap: () async {
                        final Widget searchSoilTypePage = SearchSoilTypePage();
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => searchSoilTypePage,
                          ),
                        );
                        if (!context.mounted) return;
                        if (result is SoilTypeEntitiy) {
                          _fieldSoilTypeController.text = result.name;
                          context.read<AddFieldCubit>().soilTypeChanged(
                            result.id,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Memberi jarak setelah Row
              CustomFormTextField(
                label: "Dusun",
                keyboardType: TextInputType.text,
                isPassword: false,
                isNumber: false,
                controller: _fieldDusunController,
                obsecureText: false,
                onChanged: (value) =>
                    context.read<AddFieldCubit>().subVillageChanged(value),
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                label: "Desa",
                keyboardType: TextInputType.text,
                isPassword: false,
                isNumber: false,
                controller: _fieldDesaController,
                obsecureText: false,
                onChanged: (value) =>
                    context.read<AddFieldCubit>().villageChanged(value),
              ),
              const SizedBox(height: 20),
              CustomFormTextField(
                label: "Kecamatan",
                keyboardType: TextInputType.text,
                isPassword: false,
                isNumber: false,
                controller: _fieldKecamatanController,
                obsecureText: false,
                onChanged: (value) =>
                    context.read<AddFieldCubit>().districtChanged(value),
              ),
              const SizedBox(height: 20),
              // Panggil InitialLocationPage di sini
              InitialLocationPage(
                selectedLocation: currentLocation,
                onTap: () async {
                  LatLng? locationForMap;
                  if (currentLocation != null) {
                    locationForMap = currentLocation;
                  } else {
 
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
                    final address = result.address;
                    final location = result.selectedLocation;
                    _fieldDusunController.text = address.hamlet ?? '';
                    _fieldDesaController.text = address.village ?? '';
                    _fieldKecamatanController.text =
                        address.city_district ?? '';
                    context.read<AddFieldCubit>().locationChanged(
                      location: location,
                      subVillage: address.hamlet ?? '',
                      village: address.village ?? '',
                      district: address.city_district ?? '',
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomButtonField(
                text: "Simpan Lahan",
                isEnabled: isFormValid,
                onPressed: () {
                  context.read<AddFieldCubit>().submitField();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
