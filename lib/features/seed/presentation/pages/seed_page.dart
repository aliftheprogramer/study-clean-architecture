import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart'; // Pastikan import ini ada
import 'package:clean_architecture_poktani/features/seed/domain/usecase/get_seeds_usecase.dart';
import 'package:clean_architecture_poktani/features/seed/presentation/bloc/seed_cubit.dart';
import 'package:clean_architecture_poktani/features/seed/presentation/bloc/seed_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';

class SeedPage extends StatelessWidget {
  const SeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SeedCubit(sl<GetSeedsUseCase>())..fetchSeeds(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pilih Benih')), // Judul diubah
        body: BlocBuilder<SeedCubit, SeedState>(
          builder: (context, state) {
            if (state is SeedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SeedSuccess) {
              if (state.seeds.isEmpty) {
                return const Center(child: Text('Tidak ada data benih.'));
              }
              return ListView.builder(
                itemCount: state.seeds.length,
                itemBuilder: (context, index) {
                  final seed = state.seeds[index];
                  return ListTile(
                    title: Text(seed.name),
                    subtitle: Text(
                      'Varietas: ${seed.variety}\nStok: ${seed.stock} ${seed.unit}',
                    ),
                    trailing: Text('Rp ${seed.price.toStringAsFixed(0)}'),
                    // --- TAMBAHKAN INI ---
                    onTap: () {
                      // Mengembalikan data 'seed' ke halaman sebelumnya
                      Navigator.pop(context, seed);
                    },
                    // ---------------------
                  );
                },
              );
            } else if (state is SeedFailure) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
