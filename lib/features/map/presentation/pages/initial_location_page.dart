// initial_location_page.dart

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class InitialLocationPage extends StatelessWidget {
  final LatLng? selectedLocation;
  final VoidCallback onTap;

  const InitialLocationPage({
    super.key,
    required this.selectedLocation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool hasLocation = selectedLocation != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              hasLocation
                  ? Icons.edit_location_alt_outlined
                  : Icons.map_outlined,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hasLocation ? 'Lokasi Telah Dipilih' : 'Pilih Lokasi Lahan',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasLocation
                        ? 'Lat: ${selectedLocation!.latitude.toStringAsFixed(5)}, Lon: ${selectedLocation!.longitude.toStringAsFixed(5)}'
                        : 'Ketuk untuk membuka peta',
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
