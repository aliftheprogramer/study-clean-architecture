import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register/register_data.dart';
import 'package:flutter/material.dart';

class DetailDataDiriPageTes extends StatelessWidget {
  final RegisterData registrationData;
  const DetailDataDiriPageTes({super.key, required this.registrationData});

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
            Text("Phone Number: ${registrationData.phone_number}"),
            SizedBox(height: 16),
            Text("Password: ${registrationData.password}"),
            SizedBox(height: 16),
            Text(
              "Password Confirmation: ${registrationData.password_confirmation}",
            ),
          ],
        ),
      ),
    );
  }
}
