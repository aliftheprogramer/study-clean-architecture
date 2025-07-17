import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state.dart';
import 'package:clean_architecture_poktani/features/auth/presentation/bloc/remote/final_register/button_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSubmitAuthButtonFinal extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;

  const CustomSubmitAuthButtonFinal({
    super.key,
    required this.label,
    this.isLoading = false,
    required this.onPressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonStateCubit, ButtonState>(
      builder: (context, state) {
        if (state is ButtonLoadingState) {
          return _loading(context);
        } else {
          return _initial(context);
        }
      },
    );
  }

  Widget _loading(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(),
    );
  }

  Widget _initial(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black,
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: Text(label),
      ),
    );
  }
}
