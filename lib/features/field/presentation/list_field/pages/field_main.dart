import 'package:clean_architecture_poktani/features/field/presentation/add_field/pages/add_field.dart';
import 'package:clean_architecture_poktani/features/field/presentation/detail_field/pages/detail_field_page.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_cubit.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/bloc/field_state.dart';
import 'package:clean_architecture_poktani/features/field/presentation/list_field/pages/widget/item_list_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FieldMainPage extends StatelessWidget {
  const FieldMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lahanku',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: BlocProvider(
        // Cubit sekarang mengelola semuanya, termasuk pemanggilan data awal
        create: (context) => ListFieldCubit(),
        child: const _FieldListView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFieldPage()),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FieldListView extends StatelessWidget {
  const _FieldListView();

  @override
  Widget build(BuildContext context) {
    final scrollController = context.read<ListFieldCubit>().scrollController;

    return BlocBuilder<ListFieldCubit, ListFieldState>(
      builder: (context, state) {
        // ... (bagian state loading dan error tidak berubah)
        if (state is ListFieldInitial || state is ListFieldLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ListFieldError) {
          return Center(child: Text(state.message));
        }

        if (state is ListFieldLoaded) {
          if (state.fields.isEmpty) {
            return const Center(child: Text('Tidak ada data lahan.'));
          }
          return ListView.builder(
            controller: scrollController,
            itemCount: state.hasReachedMax
                ? state.fields.length
                : state.fields.length + 1,
            itemBuilder: (context, index) {
              if (index >= state.fields.length) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final field = state.fields[index];

              // DIUBAH: Bungkus ItemListField dengan InkWell untuk membuatnya bisa diklik
              return InkWell(
                onTap: () {
                  // Navigasi ke halaman detail dengan membawa ID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // Kirim ID ke DetailFieldPage melalui constructor
                      builder: (context) => DetailFieldPage(
                        fieldId: field.id
                            .toString(), // Asumsi 'field' punya properti 'id'
                      ),
                    ),
                  );
                },
                child: ItemListField(
                  // Properti lainnya tetap sama
                  pictureUrl: field.pictureUrl ?? 'assets/rawr.png',
                  soil_type: field.soilType ?? '',
                  sub_village: field.address?.subVillage ?? '',
                  name: field.name ?? '',
                  village: field.address?.village ?? '',
                  district: field.address?.district ?? '',
                  landArea: field.landArea?.toString() ?? '',
                  seedName: field.activeCrop?.seedName ?? '',
                ),
              );
            },
          );
        }

        return const Center(child: Text("state kgk ada."));
      },
    );
  }
}
