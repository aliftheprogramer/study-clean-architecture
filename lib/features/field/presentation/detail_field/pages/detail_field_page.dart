// file: features/field/presentation/detail_field/detail_field_page.dart

import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/bloc/detail_field_bloc.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/bloc/detail_field_state.dart';
import 'package:clean_architecture_poktani/widget/custom_button_fleld.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailFieldPage extends StatelessWidget {
  const DetailFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailFieldBloc()..add(const FetchDetailField(28)),
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: BlocBuilder<DetailFieldBloc, DetailFieldState>(
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

  Widget _buildHeader(BuildContext context, String fieldName) {
    // ... (Tidak ada perubahan di sini, _buildHeader tetap sama)
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
                        onPressed: () {},
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
        // DIUBAH: Menggunakan .stretch agar semua kartu melebar penuh
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFieldInfoCard(context, field),
          const SizedBox(height: 24),
          if (field.activeCrop == null)
            _buildAddCropCard(context)
          else
            _buildActiveCropDetails(context, field.activeCrop!),

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
    return Card(
      // DIUBAH: Menghilangkan shadow dan menambah border
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

  Widget _buildActiveCropDetails(
    BuildContext context,
    ActiveCropDetailEntity crop,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          // DIUBAH: Menghilangkan shadow dan menambah border
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
                  'Tanaman Aktif',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                _buildInfoRow(
                  Icons.grass_outlined,
                  'Jenis Tanaman',
                  crop.seed.name,
                ),
                _buildInfoRow(
                  Icons.eco_outlined,
                  'Varietas',
                  crop.seed.variety,
                ),
                _buildInfoRow(
                  Icons.date_range_outlined,
                  'Tanggal Tanam',
                  crop.plantingDate,
                ),
                _buildInfoRow(
                  Icons.groups_outlined,
                  'Koordinator',
                  crop.coordinatorName,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildUsageSection(
          context: context,
          title: 'Pupuk yang Digunakan',
          items: crop.fertilizersUsed,
          emptyMessage: 'Belum ada data pupuk yang ditambahkan.',
          buttonLabel: 'Tambah Data Pupuk',
          onButtonPressed: () {},
          itemBuilder: (item) => _buildUsageItemCard(
            item.name,
            'Tanggal: ${item.applicationDate}',
            'Jumlah: ${item.quantity} ${item.unit}',
          ),
        ),
        const SizedBox(height: 24),
        _buildUsageSection(
          context: context,
          title: 'Pestisida yang Digunakan',
          items: crop.pesticidesUsed,
          emptyMessage: 'Belum ada data pestisida yang ditambahkan.',
          buttonLabel: 'Tambah Data Pestisida',
          onButtonPressed: () {},
          itemBuilder: (item) => _buildUsageItemCard(
            item.name,
            'Tanggal: ${item.applicationDate}',
            'Jumlah: ${item.quantity} ${item.unit}',
          ),
        ),
      ],
    );
  }

  Widget _buildUsageSection<T>({
    required BuildContext context,
    required String title,
    required List<T>? items,
    required String emptyMessage,
    required String buttonLabel,
    required VoidCallback onButtonPressed,
    required Widget Function(T item) itemBuilder,
  }) {
    // ... (Tidak ada perubahan signifikan di sini, kecuali penggunaan _buildUsageItemCard yang sudah diubah)
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (items == null || items.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                emptyMessage,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...items.map(itemBuilder),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: Text(buttonLabel),
            onPressed: onButtonPressed,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUsageItemCard(String title, String subtitle1, String subtitle2) {
    return Card(
      // DIUBAH: Menghilangkan shadow dan menambah border
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300, width: 1),
      ),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('$subtitle1\n$subtitle2'),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildAddCropCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            const Icon(Icons.eco_rounded, size: 50, color: Colors.green),
            const SizedBox(height: 16),
            const Text(
              'Lahan ini belum memiliki tanaman aktif.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_circle_outline, color: Colors.white),
              label: const Text(
                'Tambah Tanaman',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    // ... (Tidak ada perubahan di sini)
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
}
