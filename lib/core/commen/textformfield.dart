import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.hint,
      this.validator,
      super.key,
      this.onChanged,
      this.readOnly = false,
      this.autovalidate = false,
      this.autofocus = false,
      this.label = "",
      this.keybordtupe = TextInputType.number,
      required this.width,
      required this.controller,
      this.ontap,
      this.onsubmitted,
      this.textInputAction = TextInputAction.unspecified});
  final TextInputType keybordtupe;
  final String hint;
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onsubmitted;
  final String? Function()? ontap;
  final double width;
  final bool autovalidate;
  final bool autofocus;
  final bool readOnly;
  final TextInputAction textInputAction;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: width,
          child: TextFormField(
              autofocus: autofocus,
              textInputAction: textInputAction,
              onFieldSubmitted: onsubmitted,
              readOnly: readOnly,
              onTap: ontap,
              onChanged: onChanged,
              inputFormatters: const [],
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              controller: controller,
              keyboardType: keybordtupe,
              decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.teal)),
                  border: const OutlineInputBorder(),
                  hintText: hint,
                  labelText: label.isEmpty ? hint : label,
                  labelStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: const Color.fromARGB(31, 184, 161, 161),
                  filled: true)),
        ),
      ],
    );
  }
}
