import 'package:flutter/material.dart';
import 'package:rider/utils/colors.dart';

class MyTextformfield extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? hintText;
  final Widget? trailing;

  const MyTextformfield(
      {super.key,
      required this.controller,
      required this.onChanged,
      this.hintText,
      this.trailing,
      });

  @override
  State<MyTextformfield> createState() => _MyTextformfieldState();
}

class _MyTextformfieldState extends State<MyTextformfield> {
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Adjust the radius here
          borderSide: BorderSide.none, // Set this to remove the visible border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0), // Match the same radius
          borderSide: BorderSide(
            color: AppColors.accent, // Customize the color for focused state
            width: 1.0,
          ),
        ),
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0, // Add padding vertically
          horizontal: 12.0, // Add padding horizontally
        ),
        suffixIcon: widget.trailing,
      ),
      keyboardType: TextInputType.text,
    );
  }
}
