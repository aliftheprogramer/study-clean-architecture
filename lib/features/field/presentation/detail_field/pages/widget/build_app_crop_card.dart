import 'package:flutter/material.dart';

class BuildAddCropCard extends StatelessWidget {
  final VoidCallback? onAdd;

  const BuildAddCropCard({super.key, this.onAdd});

  @override
  Widget build(BuildContext context) {
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
              onPressed: onAdd ?? () {},
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
}
