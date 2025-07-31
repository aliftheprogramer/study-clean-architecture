import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/crop/domain/entity/request/entity_request_add_crop.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/bloc/add_crop_cubit.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/bloc/add_crop_state.dart';
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
    return BlocProvider(
      create: (context) => sl<AddCropCubit>(),
      child: AddCropDirectlyView(fieldId: fieldId),
    );
  }
}

class AddCropDirectlyView extends StatefulWidget {
  final String fieldId;
  const AddCropDirectlyView({super.key, required this.fieldId});

  @override
  State<AddCropDirectlyView> createState() => _AddCropDirectlyViewState();
}

class _AddCropDirectlyViewState extends State<AddCropDirectlyView> {
  // 1. State Management untuk Form
  final _formKey = GlobalKey<FormState>();
  final _seedController = TextEditingController();
  final _plantingDateController = TextEditingController();
  final _quantityController = TextEditingController();
  final _coordinatorIdController = TextEditingController();

  SeedEntity? _selectedSeed;
  DateTime? _selectedDate;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Listener untuk validasi form secara real-time
    _seedController.addListener(_validateForm);
    _plantingDateController.addListener(_validateForm);
    _quantityController.addListener(_validateForm);
    _coordinatorIdController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Jangan lupa dispose controller
    _seedController.dispose();
    _plantingDateController.dispose();
    _quantityController.dispose();
    _coordinatorIdController.dispose();
    super.dispose();
  }

  // 2. Fungsi Logika
  void _validateForm() {
    final isValid =
        _selectedSeed != null &&
        _plantingDateController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty &&
        _coordinatorIdController.text.isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  Future<void> _selectSeed(BuildContext context) async {
    // Pindah ke halaman SeedPage dan tunggu hasilnya
    final result = await Navigator.push<SeedEntity>(
      context,
      MaterialPageRoute(builder: (context) => const SeedPage()),
    );

    // Jika ada hasil (user memilih benih), update state
    if (result != null) {
      setState(() {
        _selectedSeed = result;
        _seedController.text = result.name;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        // Format tanggal sesuai kebutuhan API: YYYY-MM-DD
        _plantingDateController.text = DateFormat(
          'yyyy-MM-dd',
        ).format(pickedDate);
      });
    }
  }

  void _submitForm(BuildContext context) {
    if (_isFormValid) {
      final cropData = EntityRequestAddCrop(
        seedId: _selectedSeed!.id, // Menggunakan id dari benih yang dipilih
        nurseryId: null, // null karena ini tanam langsung
        plantingDate: _plantingDateController.text,
        plantQuantity: double.tryParse(_quantityController.text) ?? 0.0,
        fieldCoordinatorId: int.tryParse(_coordinatorIdController.text) ?? 0,
      );

      context.read<AddCropCubit>().addCrop(
        fieldId: widget.fieldId,
        cropData: cropData,
      );
    }
  }

  // 3. UI (Build Method)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Tanam Langsung')),
      body: BlocConsumer<AddCropCubit, AddCropState>(
        listener: (context, state) {
          if (state is AddCropSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Sukses menambahkan tanaman: ${state.crop.seed?.name}',
                ),
                backgroundColor: Colors.green,
              ),
            );
            // Kembali ke 2 halaman sebelumnya (melewati halaman pilihan)
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          } else if (state is AddCropFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AddCropLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Field Pilih Benih
                  CustomFormTextField(
                    label: 'Benih',
                    controller: _seedController,
                    onTap: () => _selectSeed(context),
                  ),
                  const SizedBox(height: 16),

                  // Field Tanggal Tanam
                  CustomFormTextField(
                    label: 'Tanggal Tanam',
                    controller: _plantingDateController,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 16),

                  // Field Jumlah Tanaman
                  CustomFormTextField(
                    label: 'Jumlah Tanaman',
                    controller: _quantityController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    // Menggunakan onChanged dari widget custom Anda
                    onChanged: (_) => _validateForm(),
                  ),
                  const SizedBox(height: 16),

                  // Field ID Koordinator
                  CustomFormTextField(
                    label: 'ID Koordinator Lapangan',
                    controller: _coordinatorIdController,
                    isNumber: true,
                    onChanged: (_) => _validateForm(),
                  ),
                  const SizedBox(height: 32),

                  // Tombol Submit
                  CustomButtonField(
                    text: 'Simpan Tanaman',
                    isEnabled: _isFormValid,
                    onPressed: () => _submitForm(context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
