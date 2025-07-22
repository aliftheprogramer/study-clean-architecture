import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/login_request_model.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/signin_usecases.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state_cubit.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_auth_text_field.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_submit_auth_button_final.dart';
import 'package:clean_architecture_poktani/features/main/presentation/pages/pages_screen.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/remote/final_register/button_state.dart';

class LoginPages extends StatelessWidget {
  LoginPages({super.key});

  final ValueNotifier<bool> _obscureTextModifier = ValueNotifier<bool>(true);
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PagesScreen()),
              );
            }
            if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  backgroundColor: Colors.red,
                ),
              );
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
            CustomSubmitAuthButtonFinal(
              label: "Login",
              onPressed: () {
                context.read<ButtonStateCubit>().execute(
                  usecase: sl<SigninUsecases>(),
                  params: SignInReqParams(
                    identifier: _phoneNumberController.text,
                    password: _passwordController.text,
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
