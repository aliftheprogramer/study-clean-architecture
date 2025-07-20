import 'package:clean_architecture_poktani/core/services/services_locator.dart';
import 'package:clean_architecture_poktani/features/auth/data/models/signup_req.dart';
import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register/register_data.dart';
import 'package:clean_architecture_poktani/features/auth/domain/usecase/signup_usecases.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state_cubit.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_auth_text_field.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/pages/widget/custom_submit_auth_button_final.dart';
import 'package:clean_architecture_poktani/features/main/presentation/pages/main_navigator_page.dart';
import 'package:clean_architecture_poktani/features/profile/presentation/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailDataDiriPageTes extends StatelessWidget {
  final RegisterData registrationData;

  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _alamatLengkapController =
      TextEditingController();
  DetailDataDiriPageTes({super.key, required this.registrationData});

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
                MaterialPageRoute(builder: (context) => const ProfilePage()),
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
            _createAccountButton(context),
          ],
        ),
      ),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return CustomSubmitAuthButtonFinal(
      label: "Daftar Petani",
      onPressed: () {
        context.read<ButtonStateCubit>().execute(
          usecase: sl<SignupUsecase>(),
          params: SignupReqParams(
            name: _namaLengkapController.value.text,
            password: registrationData.password,
            password_confirmation: registrationData.password_confirmation,
            phone_number: registrationData.phone_number,
            address: _alamatLengkapController.text,
            email: '',
          ),
        );
      },
    );
  }
}
