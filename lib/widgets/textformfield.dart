import 'package:flutter/material.dart';

class CTextFormField extends StatefulWidget {
  final bool? multiline;
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final Color? fillColor;
  final Widget? prefix;
  final Widget? suffix;
  final VoidCallback? onClickPrefix;
  final VoidCallback? onClickSuffix;
  final String errorText;
  final bool obscureText;

  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  const CTextFormField({
    super.key,
    this.hint,
    this.prefix,
    this.suffix,
    this.multiline,
    this.label,
    this.controller,
    this.fillColor,
    this.onClickPrefix,
    this.onClickSuffix,
    this.errorText = '',
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.onChanged,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
  });

  @override
  State<CTextFormField> createState() => _CTextFormFieldState();
}

class _CTextFormFieldState extends State<CTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: false,
      textCapitalization: widget.textCapitalization,
      textAlignVertical: TextAlignVertical.center,
      controller: widget.controller,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autofocus: widget.autofocus,
      maxLength: widget.maxLength,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: (String value) {
        widget.onChanged?.call(value);
      },
      validator: (String? value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        return null;
      },
      onFieldSubmitted: widget.onFieldSubmitted,
      readOnly: widget.readOnly,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        fillColor: widget.fillColor ?? Colors.white,
        labelText: widget.label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16,
          color: Color(0xFF878787),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: Color(0xFF878787),
        ),
        suffixIcon: widget.suffix,
        prefixIcon: widget.prefix,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        filled: true,
        isCollapsed: true,
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
    );
  }
}
