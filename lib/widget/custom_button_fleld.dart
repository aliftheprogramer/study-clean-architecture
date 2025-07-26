import 'package:flutter/material.dart';

class CustomButtonField extends StatelessWidget {
  /// Teks yang akan ditampilkan di tombol.
  final String text;

  /// Kondisi untuk mengaktifkan tombol. Jika `true`, tombol akan berwarna hijau dan bisa diklik.
  /// Jika `false`, tombol akan berwarna abu-abu dan tidak bisa diklik.
  final bool isEnabled;

  /// Fungsi yang akan dijalankan saat tombol ditekan.
  final VoidCallback? onPressed;

  const CustomButtonField({
    super.key,
    required this.text,
    this.isEnabled = false, // Defaultnya tombol tidak aktif
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Membuat lebar tombol memenuhi layar
      height: 50, // Memberi tinggi yang pas
      child: ElevatedButton(
        // Kuncinya ada di sini:
        // Jika isEnabled true, gunakan fungsi onPressed.
        // Jika false, berikan null agar tombol otomatis non-aktif.
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
