import 'package:flutter/material.dart';

class AddCropDirectlyPage extends StatelessWidget {
  final int fieldId;
  const AddCropDirectlyPage({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Tambah Tanaman')),
        body: Center(child: Text('Field ID: $fieldId')),
      ),
    );
  }
}
