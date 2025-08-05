import 'package:clean_architecture_poktani/features/field/domain/entity/response/detail_field/response_detail_field_entity.dart';
import 'package:flutter/material.dart';
import 'build_usage_section.dart';

class BuildActiveCropDetails extends StatelessWidget {
  final ActiveCropDetailEntity? crop;
  final VoidCallback? onAddFertilizer;
  final VoidCallback? onAddPesticide;

  const BuildActiveCropDetails({
    super.key,
    required this.crop,
    this.onAddFertilizer,
    this.onAddPesticide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
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
                  crop?.seed.name ?? '',
                ),
                _buildInfoRow(
                  Icons.eco_outlined,
                  'Varietas',
                  crop?.seed.variety ?? '',
                ),
                _buildInfoRow(
                  Icons.date_range_outlined,
                  'Tanggal Tanam',
                  crop?.plantingDate ?? '',
                ),
                _buildInfoRow(
                  Icons.groups_outlined,
                  'Koordinator',
                  crop?.coordinatorName ?? '',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        BuildUsageSection(
          title: 'Pupuk yang Digunakan',
          items: crop?.fertilizersUsed ?? [],
          emptyMessage: 'Belum ada data pupuk yang ditambahkan.',
          buttonLabel: 'Tambah Data Pupuk',
          onButtonPressed: onAddFertilizer ?? () {},
          itemBuilder: (item) => _buildUsageItemCard(
            item.name,
            'Tanggal: ${item.applicationDate}',
            'Jumlah: ${item.quantity} ${item.unit}',
          ),
        ),
        const SizedBox(height: 24),
        BuildUsageSection(
          title: 'Pestisida yang Digunakan',
          items: crop?.pesticidesUsed ?? [],
          emptyMessage: 'Belum ada data pestisida yang ditambahkan.',
          buttonLabel: 'Tambah Data Pestisida',
          onButtonPressed: onAddPesticide ?? () {},
          itemBuilder: (item) => _buildUsageItemCard(
            item.name,
            'Tanggal: ${item.applicationDate}',
            'Jumlah: ${item.quantity} ${item.unit}',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
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

  Widget _buildUsageItemCard(String title, String subtitle1, String subtitle2) {
    return Card(
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
}
