// file: features/field/presentation/detail_field/pages/detail_field_page.dart

import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/bloc/detail_field_cubit.dart'; // DIUBAH: Impor Cubit
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/bloc/detail_field_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/pages/widget/build_active_crop_details.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/pages/widget/build_app_crop_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_poktani/widget/custom_button_fleld.dart';

import '../../../../crop/presentation/page/add_crop_option_page.dart';

// ... (impor lainnya tetap sama)

class DetailFieldPage extends StatelessWidget {
  // 1. Tambahkan properti final untuk menampung ID
  final String fieldId;

  // 2. Buat constructor untuk menerima fieldId
  const DetailFieldPage({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    // 3. Hapus ID yang di-hardcode. Kita akan gunakan `fieldId` dari properti class.

    return BlocProvider(
      // 4. Gunakan `fieldId` yang diterima dari constructor
      create: (context) => DetailFieldCubit()..fetchDetailField(fieldId),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: BlocBuilder<DetailFieldCubit, DetailFieldState>(
            builder: (context, state) {
              if (state is DetailFieldLoading || state is DetailFieldInitial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is DetailFieldLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(context, state.fieldDetail.name),
                      _buildBody(context, state.fieldDetail),
                    ],
                  ),
                );
              }
              if (state is DetailFieldError) {
                return Center(child: Text(state.message));
              }
              return const Center(child: Text('Terjadi kesalahan'));
            },
          ),
        ),
      ),
    );
  }

  // ... (sisa kode _buildHeader, _buildBody, dll. tidak perlu diubah)
  // ...
}

Widget _buildHeader(BuildContext context, String fieldName) {
  return SizedBox(
    height: 170.0,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/backgroundappbar1.png', fit: BoxFit.cover),
        SafeArea(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      iconSize: 28.0,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        fieldName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.black),
                      iconSize: 28.0,
                      onPressed: () {
                        // TODO: Implement more options logic
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBody(BuildContext context, FieldDetailEntity field) {
  final bool isButtonEnabled =
      field.activeCrop != null &&
      field.activeCrop!.fertilizersUsed != null &&
      field.activeCrop!.fertilizersUsed!.isNotEmpty;

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildFieldInfoCard(context, field),
        const SizedBox(height: 24),
        if (field.activeCrop == null)
          BuildAddCropCard(
            onAdd: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCropOptionPage(fieldId: field.id),
                ),
              );
            },
          )
        else
          BuildActiveCropDetails(
            crop: field.activeCrop!,
            // DIUBAH: Mengimplementasikan callback
            onAddFertilizer: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigasi ke halaman Tambah Pupuk...'),
                ),
              );
              // Navigasi ke halaman tambah pupuk
            },
            onAddPesticide: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigasi ke halaman Tambah Pestisida...'),
                ),
              );
              // Navigasi ke halaman tambah pestisida
            },
          ),
        const SizedBox(height: 24),
        CustomButtonField(
          text: 'Siap Panen',
          isEnabled: isButtonEnabled,
          onPressed: isButtonEnabled
              ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Lahan siap panen!')),
                  );
                }
              : null,
        ),
      ],
    ),
  );
}

Widget _buildFieldInfoCard(BuildContext context, FieldDetailEntity field) {
  // ... (Tidak ada perubahan di widget ini)
  return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey.shade300, width: 1.5),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Lahan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          _buildInfoRow(Icons.person_outline, 'Pemilik', field.owner.name),
          _buildInfoRow(
            Icons.terrain_outlined,
            'Luas Lahan',
            '${field.landArea} m²',
          ),
          _buildInfoRow(
            Icons.map_outlined,
            'Alamat',
            field.address.toFullString(),
          ),
          _buildInfoRow(Icons.layers_outlined, 'Jenis Tanah', field.soilType),
        ],
      ),
    ),
  );
}

Widget _buildInfoRow(IconData icon, String title, String value) {
  // ... (Tidak ada perubahan di widget ini)
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 16),
        Text('$title:', style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 8),
        Expanded(child: Text(value)),
      ],
    ),
  );
}
