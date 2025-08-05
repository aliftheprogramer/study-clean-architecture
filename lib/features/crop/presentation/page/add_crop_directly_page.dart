import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/request/entity_request_add_crop.dart';
// DIUBAH: Import usecase
import 'package:clean_architecture_poktani/features/crop/domain/usecase/add_crop_usecase.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/bloc/add_crop_cubit.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/bloc/add_crop_state.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/bloc/from_direcly/add_crop_directly_dorm_state.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/bloc/from_direcly/add_crop_directly_form_cubit.dart';
import 'package:clean_architecture_poktani/features/seed/domain/entity/seed_list_response_entity.dart';
import 'package:clean_architecture_poktani/features/seed/presentation/pages/seed_page.dart';
import 'package:clean_architecture_poktani/widget/custom_button_fleld.dart';
import 'package:clean_architecture_poktani/widget/custom_form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddCropDirectlyPage extends StatelessWidget {
  final String fieldId;
  const AddCropDirectlyPage({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => AddCropCubit(sl<AddCropUsecase>())),
        BlocProvider(create: (context) => AddCropDirectlyFormCubit()),
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Tanam Langsung')),
          body: _AddCropDirectlyView(fieldId: fieldId),
        ),
      ),
    );
  }
}

class _AddCropDirectlyView extends StatelessWidget {
  final String fieldId;
  const _AddCropDirectlyView({required this.fieldId});

  void _selectSeed(BuildContext context) async {
    final result = await Navigator.push<SeedEntity>(
      context,
      MaterialPageRoute(builder: (context) => const SeedPage()),
    );

    if (result != null && context.mounted) {
      context.read<AddCropDirectlyFormCubit>().seedChanged(result);
    }
  }

  void _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && context.mounted) {
      context.read<AddCropDirectlyFormCubit>().dateChanged(pickedDate);
    }
  }

  void _submitCrop(BuildContext context, AddCropDirectlyFormState formState) {
    if (!formState.isFormValid) return;

    final cropData = EntityRequestAddCrop(
      seedId: formState.selectedSeed!.id,
      plantingDate: DateFormat('yyyy-MM-dd').format(formState.selectedDate!),
      plantQuantity: double.parse(formState.plantQuantity),
      fieldCoordinatorId: int.parse(formState.fieldCoordinatorId),
    );

    context.read<AddCropCubit>().addCrop(fieldId: fieldId, cropData: cropData);
  }

  @override
  Widget build(BuildContext context) {
    final seedController = TextEditingController();
    final dateController = TextEditingController();

    return BlocListener<AddCropCubit, AddCropState>(
      listener: (context, state) {
        if (state is AddCropLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddCropSuccess) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Berhasil menambahkan tanaman!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context, true); // Go back to previous page
        } else if (state is AddCropFailure) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: BlocBuilder<AddCropDirectlyFormCubit, AddCropDirectlyFormState>(
        builder: (context, formState) {
          // Update controller text based on state
          seedController.text = formState.selectedSeed?.name ?? '';
          dateController.text = formState.selectedDate != null
              ? DateFormat('yyyy-MM-dd').format(formState.selectedDate!)
              : '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomFormTextField(
                  label: 'Pilih Benih',
                  controller: seedController,
                  onTap: () => _selectSeed(context),
                ),
                const SizedBox(height: 16),
                CustomFormTextField(
                  label: 'Tanggal Tanam',
                  controller: dateController,
                  onTap: () => _selectDate(context),
                ),
                const SizedBox(height: 16),
                CustomFormTextField(
                  label: 'Jumlah Tanaman',
                  controller: TextEditingController(
                    text: formState.plantQuantity,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (value) => context
                      .read<AddCropDirectlyFormCubit>()
                      .quantityChanged(value),
                ),
                const SizedBox(height: 16),
                CustomFormTextField(
                  label: 'ID Koordinator Lapangan',
                  controller: TextEditingController(
                    text: formState.fieldCoordinatorId,
                  ),
                  isNumber: true,
                  onChanged: (value) => context
                      .read<AddCropDirectlyFormCubit>()
                      .coordinatorIdChanged(value),
                ),
                const SizedBox(height: 32),
                CustomButtonField(
                  text: 'Tambah Tanaman',
                  isEnabled: formState.isFormValid,
                  onPressed: () => _submitCrop(context, formState),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
