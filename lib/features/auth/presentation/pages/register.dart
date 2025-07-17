import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/start_register/remote_regiser_state.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/start_register/remote_register_bloc.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/start_register/remote_register_event.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/detail_data_diri_tes.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_auth_text_field.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_submit_auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final ValueNotifier<bool> _obscureTextModifier = ValueNotifier<bool>(true);
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RemoteRegisterBloc(),
        child: BlocListener<RemoteRegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              // Show loading indicator
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Loading...")));
            } else if (state is RegisterSuccess) {
              // Handle success
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Navigasi ke halaman berikutnya")),
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailDataDiriPageTes(
                    registrationData: state.registerData,
                  ),
                ),
              );
            } else if (state is RegisterFailure) {
              // Handle failure
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          child: Builder(
            builder: (context) {
              return _buildBody(context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsGeometry.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(title: Text(""), backgroundColor: Colors.white),
            const Text(
              "selamat datang ",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "Silahkan daftar untuk melanjutkan",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),

            const SizedBox(height: 32),

            CustomAuthTextField(
              label: 'No HP',
              keyboardType: TextInputType.phone,
              isPassword: false,
              isNumber: true,
              controller: _phoneNumberController,
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

            const SizedBox(height: 16),

            ValueListenableBuilder<bool>(
              valueListenable: _obscureTextModifier,
              builder: (context, isObsecure, child) {
                return CustomAuthTextField(
                  label: "Konfirmasi Password",
                  keyboardType: TextInputType.text,
                  isPassword: true,
                  isNumber: false,
                  controller: _passwordConfirmationController,
                  obsecureText: isObsecure,
                  onToggleObsecure: () {
                    _obscureTextModifier.value = !isObsecure;
                  },
                );
              },
            ),

            const SizedBox(height: 32),
            CustomSubmitAuthButton(
              label: "Selanjutnya",
              onPressed: () {
                final String phone_number = _phoneNumberController.text;
                final String password = _passwordController.text;
                final String password_confirmation =
                    _passwordConfirmationController.text;

                context.read<RemoteRegisterBloc>().add(
                  RegisterButtonPressed(
                    phoneNumber: phone_number,
                    password: password,
                    passwordConfirmation: password_confirmation,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
