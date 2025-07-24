import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/map_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/map/bloc/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// MapPickerPage tetap sama, tidak perlu diubah.
class MapPickerPage extends StatelessWidget {
  const MapPickerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pilih Lokasi dari Peta')),
        // Body sekarang langsung memanggil widget stateless baru kita
        body: MapPickerView(),
      ),
    );
  }
}

// ✅ WIDGET INI SEKARANG STATELESS
class MapPickerView extends StatelessWidget {
  MapPickerView({super.key});

  // MapController bisa dibuat di dalam build method karena tidak menyimpan
  // state yang perlu dijaga antar-rebuild dalam kasus sederhana ini.
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapCubit, MapState>(
      listener: (context, state) {
        // Bagian listener tidak perlu diubah.
        if (state is MapLoaded) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text('Lokasi ditemukan!')));
        } else if (state is MapError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        // Tidak ada lagi _selectedMarker, semua dibaca dari 'state'
        return Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(-6.9175, 107.6191),
                initialZoom: 13.0,
                onTap: (tapPosition, point) {
                  context.read<MapCubit>().getAddressFromTap(point);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                // ✅ KONDISI MARKER BERDASARKAN TIPE STATE
                // Marker hanya akan muncul jika state adalah MapLoaded.
                if (state is MapLoaded)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        // ✅ POSISI DIAMBIL LANGSUNG DARI STATE
                        point: state.selectedLocation,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            // Tampilkan informasi alamat di bawah
            if (state is MapLoaded)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alamat Terpilih:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        // Gunakan data dari Entity yang sudah kita siapkan
                        Text('Dusun: ${state.address.road ?? '-'}'),
                        Text('Desa: ${state.address.village ?? '-'}'),
                        Text('Kecamatan: ${state.address.subdistrict ?? '-'}'),
                        Text('Kota: ${state.address.city ?? '-'}'),
                        const SizedBox(height: 8),
                        Text(
                          'Koordinat: ${state.selectedLocation.latitude.toStringAsFixed(5)}, ${state.selectedLocation.longitude.toStringAsFixed(5)}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Tampilkan loading indicator
            if (state is MapLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}
