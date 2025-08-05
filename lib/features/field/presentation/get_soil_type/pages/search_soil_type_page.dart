import 'package:clean_architecture_poktani/features/field/domain/entity/response/soil_type/response_soil_type_entitiy.dart';
import 'package:clean_architecture_poktani/features/field/presentation/get_soil_type/bloc/search_soil_type_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/get_soil_type/bloc/search_soil_type_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchSoilTypePage extends StatelessWidget {
  const SearchSoilTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Jenis Tanah"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocProvider(
        create: (context) => SearchSoilTypeCubit(),
        child: BlocBuilder<SearchSoilTypeCubit, SearchSoilTypeState>(
          builder: (context, state) {
            // =======================================================
            // KONDISI UNTUK MENANGANI SETIAP STATE DARI CUBIT
            // =======================================================

            // State Awal atau sedang Loading data pertama kali
            if (state is SearchSoilTypeInitial ||
                state is SearchSoilTypeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // State jika terjadi Error
            if (state is SearchSoilTypeError) {
              return Center(child: Text(state.message));
            }

            // State jika data berhasil dimuat
            if (state is SearchSoilTypeLoaded) {
              if (state.soilTypes.isEmpty) {
                return const Center(
                  child: Text("Data jenis tanah tidak ditemukan."),
                );
              }

              // Gunakan ListView.builder untuk menampilkan daftar data
              return ListView.builder(
                // Tambah 1 item untuk loading indicator di bawah (pagination)
                itemCount: state.hasReachedMax
                    ? state.soilTypes.length
                    : state.soilTypes.length + 1,
                // Sambungkan scrollController dari Cubit untuk deteksi scroll
                controller: context
                    .read<SearchSoilTypeCubit>()
                    .scrollController,
                itemBuilder: (context, index) {
                  // Jika ini item terakhir dan belum mentok, tampilkan loading
                  if (index >= state.soilTypes.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // Ambil data satu per satu dari list
                  final soilType = state.soilTypes[index];

                  // Panggil method untuk membuat card dinamis
                  return _buildCardSoilType(context, soilType);
                },
              );
            }

            // State default jika tidak ada kondisi yang terpenuhi
            return const Center(child: Text("Silakan cari jenis tanah."));
          },
        ),
      ),
    );
  }

  /// Membuat widget Card untuk menampilkan detail jenis tanah secara dinamis.
  Widget _buildCardSoilType(BuildContext context, SoilTypeEntitiy soilType) {
    return InkWell(
      onTap: () {
        // Mengembalikan data 'soilType' yang dipilih ke halaman sebelumnya
        Navigator.pop(context, soilType);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.layers_outlined, // Anda bisa ganti ikonnya
                size: 40,
                color: Colors.brown.shade600,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      soilType.name, // Data dinamis dari state
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      soilType.description, // Data dinamis dari state
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
