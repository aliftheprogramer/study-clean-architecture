import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:flutter/material.dart';

class ItemListField extends StatelessWidget {
  final ListFieldEntity listFieldEntity;
  const ItemListField({super.key, required this.listFieldEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // Menambahkan border di sini
          side: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        // Menghilangkan shadow
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Bagian Gambar ---
            _buildImage(listFieldEntity.pictureUrl),

            // --- Bagian Konten ---
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Nama Lahan ---
                  Text(
                    listFieldEntity.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // --- Detail Informasi dengan Ikon ---
                  _buildInfoRow(
                    icon: Icons.location_on_outlined,
                    text:
                        '${listFieldEntity.address.subVillage}, ${listFieldEntity.address.district}',
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    icon: Icons.straighten_outlined,
                    text: '${listFieldEntity.landArea} m²',
                  ),
                  const SizedBox(height: 6),
                  _buildInfoRow(
                    icon: Icons.energy_savings_leaf_outlined,
                    text: 'Tanaman: ${listFieldEntity.activeCrop.seedName}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan gambar atau placeholder
  Widget _buildImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.asset(
        imageUrl,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
        // Menambahkan error builder jika gambar gagal dimuat
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
    // Jika URL null atau kosong, tampilkan placeholder
    return _buildPlaceholder();
  }

  // Widget untuk placeholder gambar
  Widget _buildPlaceholder() {
    return Container(
      height: 150,
      width: double.infinity,
      color: Colors.grey[200],
      child: Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey[400],
        size: 50,
      ),
    );
  }

  // Widget helper untuk baris informasi (ikon + teks)
  Widget _buildInfoRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.green[700], size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
