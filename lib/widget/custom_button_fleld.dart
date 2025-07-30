import 'package:flutter/material.dart';

class CustomButtonField extends StatelessWidget {
  /// Teks yang akan ditampilkan di tombol.
  final String text;

  /// Kondisi untuk mengaktifkan tombol. Jika `true`, tombol akan aktif.
  /// Jika `false`, tombol akan non-aktif.
  final bool isEnabled;

  /// Fungsi yang akan dijalankan saat tombol ditekan.
  final VoidCallback? onPressed;

  // Hapus 'color' dari constructor ini
  const CustomButtonField({
    super.key,
    required this.text,
    this.isEnabled = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        // Logika ini sudah benar: jika isEnabled, gunakan onPressed, jika tidak, null.
        // Flutter akan otomatis menonaktifkan tombol jika onPressed-nya null.
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          // Ganti warna berdasarkan isEnabled
          backgroundColor: isEnabled ? Colors.green : Colors.grey.shade400,
          foregroundColor: Colors.white, // Warna teks
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: isEnabled ? 3 : 0, // Beri bayangan hanya jika aktif
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
