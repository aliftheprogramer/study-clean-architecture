import 'package:clean_architecture_poktani/widget/custom_form_text_field.dart';
import 'package:flutter/widgets.dart';

class CustomSoilTypeDropDown extends StatelessWidget {
  const CustomSoilTypeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFormTextField(
      label: 'Tipe Tanah',
      keyboardType: TextInputType.text,
      isPassword: false,
      isNumber: false,
      controller: TextEditingController(),
      obsecureText: false,
    );
  }
}
