import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register/register_data.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_auth_text_field.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_submit_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DetailDataDiriPageTes extends StatelessWidget {
  final RegisterData registrationData;

  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _alamatLengkapController =
      TextEditingController();
  DetailDataDiriPageTes({super.key, required this.registrationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: Text("Detail Data Diri"),
              backgroundColor: Colors.white,
            ),
            CustomAuthTextField(
              label: "Nama Lengkap",
              keyboardType: TextInputType.text,
              isPassword: false,
              isNumber: false,
              controller: _namaLengkapController,
              obsecureText: false,
            ),
            SizedBox(height: 16),
            CustomAuthTextField(
              label: "Alamat Lengkap",
              keyboardType: TextInputType.text,
              isPassword: false,
              isNumber: false,
              controller: _alamatLengkapController,
              obsecureText: false,
              isAlamat: true,
            ),
            SizedBox(height: 32),
            CustomSubmitAuthButton(
              label: "Daftar Petani",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("button daftar di tekan")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
