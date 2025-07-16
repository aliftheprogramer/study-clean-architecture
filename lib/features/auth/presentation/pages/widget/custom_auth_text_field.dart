import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAuthTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool isNumber;
  final TextEditingController controller;
  final bool obsecureText;
  final VoidCallback? onToggleObsecure;

  const CustomAuthTextField({
    super.key,
    required this.label,
    required this.keyboardType,
    required this.isPassword,
    required this.isNumber,
    required this.controller,
    required this.obsecureText,
    this.onToggleObsecure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : keyboardType,
          obscureText: obsecureText,
          inputFormatters: isNumber
              ? [FilteringTextInputFormatter.digitsOnly]
              : [],
          decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.green, width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.green, width: 2.0),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: onToggleObsecure,
                    icon: Icon(
                      obsecureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  )
                : null
          ),
        ),
      ],
    );
  }
}
