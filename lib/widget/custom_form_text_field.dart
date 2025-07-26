import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool isNumber;
  final bool obsecureText;
  final TextInputType? keyboardType;
  final VoidCallback? onToggleObsecure;
  final bool isAlamat;
  final bool isShowList;
  final VoidCallback? onTap;

  // 1. TAMBAHKAN PARAMETER INI
  final ValueChanged<String>? onChanged;

  const CustomFormTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false, // Beri nilai default
    this.isNumber = false, // Beri nilai default
    this.obsecureText = false, // Beri nilai default
    this.keyboardType,
    this.onToggleObsecure,
    this.isAlamat = false,
    this.isShowList = false,
    this.onTap,
    this.onChanged, // 2. TAMBAHKAN DI CONSTRUCTOR
  });

  @override
  Widget build(BuildContext context) {
    final bool isTappable = onTap != null;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged, // 3. SAMBUNGKAN KE TEXTFIELD
          keyboardType: isAlamat
              ? TextInputType.multiline
              : (isNumber ? TextInputType.number : keyboardType),
          maxLines: isAlamat ? 4 : 1,
          minLines: isAlamat ? 4 : 1,
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
                : null,
          ),
          onTap: onTap,
          readOnly: isTappable,
        ),
      ],
    );
  }
}
