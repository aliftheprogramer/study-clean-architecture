import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class InitialLocationPage extends StatelessWidget {
  // Widget ini HANYA menerima data dari luar.
  final LatLng? selectedLocation;
  final VoidCallback onTap;

  const InitialLocationPage({
    super.key,
    required this.onTap,
    this.selectedLocation,
  });

  @override
  Widget build(BuildContext context) {
    // Tidak ada BlocProvider atau BlocBuilder di sini.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lokasi Lahan',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap:
              onTap, // Langsung panggil fungsi onTap dari parent (AddFieldPage).
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.green, width: 2.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: _buildPreview(), // Memanggil preview berdasarkan properti.
          ),
        ),
      ],
    );
  }

  // Method ini sekarang menggunakan 'selectedLocation' dari properti widget,
  // bukan dari 'state' Bloc.
  Widget _buildPreview() {
    // Jika lokasi belum dipilih, tampilkan peta default dengan overlay.
    if (selectedLocation == null) {
      return Stack(
        alignment: Alignment.center, // Pusatkan semua item di dalam Stack
        children: [
          // LAPISAN BAWAH: Peta default sebagai background
          FlutterMap(
            options: MapOptions(
              // Koordinat default, contoh: Tangerang
              initialCenter: LatLng(-6.178, 106.63),
              initialZoom: 12.0, // Zoom out untuk menunjukkan area kota
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.none, // Tidak bisa di-zoom/geser
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'com.example.app', // Ganti dengan package Anda
              ),
            ],
          ),

          // LAPISAN ATAS: Pesan untuk pengguna
          // Container dengan latar belakang sedikit gelap agar teks terbaca
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min, // Ukuran sekecil kontennya
              children: [
                Icon(Icons.touch_app_outlined, color: Colors.white, size: 32),
                SizedBox(height: 4),
                Text(
                  'Ketuk untuk Memilih Lokasi',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    // Jika lokasi sudah dipilih, tampilkan peta pratinjau dengan marker (tidak berubah).
    return FlutterMap(
      options: MapOptions(
        initialCenter: selectedLocation!,
        initialZoom: 17.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app', // Ganti dengan package Anda
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: selectedLocation!,
              width: 80,
              height: 80,
              child: const Icon(
                Icons.location_pin,
                size: 40,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
