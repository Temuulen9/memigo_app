import 'package:flutter/material.dart';

class CTextField extends StatefulWidget {
  final String? hint;
  const CTextField({
    super.key,
    this.hint,
  });

  @override
  State<CTextField> createState() => _CTextfieldState();
}

class _CTextfieldState extends State<CTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: widget.hint,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFF878787)),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFF878787)),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFFF0F0F0)),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
