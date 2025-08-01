import 'package:clean_architecture_poktani/features/crop/presentation/page/add_crop_directly_page.dart';
import 'package:clean_architecture_poktani/features/crop/presentation/page/add_crop_nursery_page.dart';
import 'package:flutter/material.dart';

class AddCropOptionPage extends StatelessWidget {
  final int fieldId;
  const AddCropOptionPage({super.key, required this.fieldId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Metode Tanam')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.move_down),
              label: const Text('Pindah Tanam (dari Persemaian)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddCropFromNurseryPage(fieldId: fieldId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.eco),
              label: const Text('Tanam Langsung'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddCropDirectlyPage(fieldId: fieldId),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
