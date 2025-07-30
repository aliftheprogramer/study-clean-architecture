import 'package:clean_architecture_poktani/features/units/domain/usecase/get_units_usecase.dart';
import 'package:clean_architecture_poktani/features/units/presentation/bloc/unit_cubit.dart';
import 'package:clean_architecture_poktani/features/units/presentation/bloc/unit_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_poktani/core/services/services_locator.dart';

class UnitPageList extends StatelessWidget {
  const UnitPageList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UnitCubit(sl<GetUnitsUseCase>())..fetchUnits(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Daftar Satuan Unit')),
        body: BlocBuilder<UnitCubit, UnitState>(
          builder: (context, state) {
            if (state is UnitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UnitSuccess) {
              if (state.units.isEmpty) {
                return const Center(child: Text('Tidak ada data satuan unit.'));
              }
              return ListView.separated(
                itemCount: state.units.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final unit = state.units[index];
                  return ListTile(
                    title: Text(unit.name),
                    subtitle: Text('ID: ${unit.id}'),
                    trailing: Text(unit.symbol),
                  );
                },
              );
            } else if (state is UnitFailure) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
