import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CustomTextField({super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            hintText,
            style: GoogleFonts.grenze(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: hintText == "Email" ? TextInputType.emailAddress : hintText == "Password" || hintText == "Password" ? TextInputType.visiblePassword : TextInputType.name,
          textInputAction: TextInputAction.next,
          obscureText: hintText == "Password" || hintText == "Confirm Password" ? true : false,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            contentPadding: const EdgeInsets.all(17),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            fillColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
