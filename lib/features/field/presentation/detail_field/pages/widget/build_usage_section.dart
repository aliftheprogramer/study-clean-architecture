import 'package:flutter/material.dart';

class BuildUsageSection<T> extends StatelessWidget {
  final String title;
  final List<T>? items;
  final String emptyMessage;
  final String buttonLabel;
  final VoidCallback onButtonPressed;
  final Widget Function(T item) itemBuilder;

  const BuildUsageSection({
    super.key,
    required this.title,
    required this.items,
    required this.emptyMessage,
    required this.buttonLabel,
    required this.onButtonPressed,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (items == null || items!.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                emptyMessage,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          )
        else
          ...items!.map(itemBuilder),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: Text(buttonLabel),
            onPressed: onButtonPressed,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
