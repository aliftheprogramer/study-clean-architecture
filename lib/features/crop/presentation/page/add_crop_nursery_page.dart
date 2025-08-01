import 'package:flutter/widgets.dart';

class AddCropFromNurseryPage extends StatelessWidget {
  final int fieldId;
  const AddCropFromNurseryPage({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Add Crop From Nursery Page - Field ID: $fieldId',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
