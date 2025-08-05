import 'package:flutter/widgets.dart';

class AddCropFromNurseryPage extends StatelessWidget {
  final int fieldId;
  AddCropFromNurseryPage({super.key, required this.fieldId});

  final TextEditingController _cropSeedIdController = TextEditingController();
  final TextEditingController _plantingDateController = TextEditingController();
  final TextEditingController _plantQuantity = TextEditingController();
  final TextEditingController _fieldCoordinatorId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Add Crop From Nursery Page - Field ID: $fieldId',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
