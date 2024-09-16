import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  String labelText;
  double? borderRadius;
  TextEditingController? myController;
  String? Function(String?)? validator;
  TextInputType? keyboardType;

  PasswordTextField(
      {super.key,
      required this.labelText,
      this.borderRadius,
      this.myController,
      this.validator,
      this.keyboardType});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  void obscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: const TextStyle(color: Colors.black),
      obscureText: _obscureText,
      controller: widget.myController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(fontSize: 12),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: obscure,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
