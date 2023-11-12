import 'package:chat_app/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final IconButton? suffix;
  final bool? obscure;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  const ChatTextFormField({
    super.key,
    required this.label,
    required this.controller,
    required this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.name,
    this.suffix,
    this.obscure = false,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: TextFormField(
        controller: controller,
        maxLines: 1,
        maxLength: maxLength,
        obscureText: obscure!,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlign: maxLength == 1 ? TextAlign.center : TextAlign.left,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(),
          focusedErrorBorder: const OutlineInputBorder(),
          focusColor: AppColors.lightThemePrimaryColor,
          suffixIconColor: AppColors.lightThemePrimaryColor,
          suffixIcon: suffix,
          counterText: "",
        ),
        inputFormatters: inputFormatters,
      ),
    );
  }
}
