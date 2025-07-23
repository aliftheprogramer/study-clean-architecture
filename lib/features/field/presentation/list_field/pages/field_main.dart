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
        // Menengahkan judul
        centerTitle: true,
        // Menambah tinggi AppBar untuk memberi jarak dari atas
        toolbarHeight: 80,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ListFieldCubit()..loadListFields()),
          // Add other providers if needed
        ],
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ListFieldCubit, ListFieldState>(
      builder: (context, state) {
        // --- Loading State ---
        if (state is ListFieldLoadingState || state is ListFieldInitialState) {
          return const Center(child: CircularProgressIndicator());
        }

        // --- Loaded State ---
        if (state is ListFieldLoadedState) {
          return ListView.builder(
            itemCount: state.fields.length,
            itemBuilder: (context, index) {
              final field = state.fields[index];
              return ItemListField(listFieldEntity: field);
            },
          );
        }

        // --- Error State ---
        if (state is ListFieldErrorState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // --- Empty State ---
        if (state is ListFieldEmptyState) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                state.message,
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Fallback state
        return const Center(
          child: Text("Terjadi kesalahan yang tidak diketahui."),
        );
      },
    );
  }
}
