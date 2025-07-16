import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_auth_text_field.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_submit_auth_button.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatelessWidget {
  LoginPages({super.key});

  final ValueNotifier<bool> _obscureTextModifier = ValueNotifier<bool>(true);
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            AppBar(title: Text(""), backgroundColor: Colors.white),
            const Text(
              "selamat datang kembali",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              "Silahkan masuk untuk melanjutkan",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),

            const SizedBox(height: 32),

            CustomAuthTextField(
              controller: _phoneNumberController,
              label: "No Hp",
              keyboardType: TextInputType.phone,
              isPassword: false,
              isNumber: true,
              obsecureText: false,
            ),

            const SizedBox(height: 16),

            ValueListenableBuilder<bool>(
              valueListenable: _obscureTextModifier,
              builder: (context, isObsecure, child) {
                return CustomAuthTextField(
                  label: "Password",
                  keyboardType: TextInputType.text,
                  isPassword: true,
                  isNumber: false,
                  controller: _passwordController,
                  obsecureText: isObsecure,
                  onToggleObsecure: () {
                    _obscureTextModifier.value = !isObsecure;
                  },
                );
              },
            ),

            const SizedBox(height: 32),
            CustomSubmitAuthButton(
              label: "Login",
              onPressed: () {
                // Implement login logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}
