import 'package:clean_architecture_poktani/features/field/domain/entity/list_field_entity.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FieldCard extends StatelessWidget {
  final ListFieldEntity field;
  const FieldCard({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,

      margin: EdgeInsets.only(right: 16, left: 16, bottom: 0),
      child: Card(
        clipBehavior: Clip.antiAlias, //cut image sesuai dengan card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: AssetImage(field.pictureUrl ?? 'assets/rawr.png'),
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    field.name ?? 'Lahan Tanpa Nama',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    field.activeCrop?.seedName ?? 'Tidak ada tanaman',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
