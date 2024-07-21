import 'package:flutter/material.dart';

Widget defaultTextFormField({
  TextEditingController? controller,
  required String label,
  required Icon prefixIcon,
  required String message,
  void Function(String)? onFieldSubmitted,
  void Function()? onTap,
  void Function(String)? onChanged,
  TextInputType? textInputType,
  bool readOnly = true,
}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: textInputType,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return '$message is required';
          }
          return null;
        },
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          label: Text(label),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(),
        ),
      ),
    );

Widget myDivier() => Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: 1,
    );
