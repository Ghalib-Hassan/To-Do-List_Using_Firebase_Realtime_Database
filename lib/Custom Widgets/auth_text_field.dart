import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SimpleAuthTextField extends StatefulWidget {
  String? labelText;
  String? hintText;
  double? borderRadius;
  TextEditingController? myController;
  String? Function(String?)? validator;
  TextInputType? keyboardType;

  SimpleAuthTextField(
      {super.key,
      this.labelText,
      this.hintText,
      this.borderRadius,
      this.myController,
      this.validator,
      this.keyboardType});

  @override
  State<SimpleAuthTextField> createState() => _SimpleAuthTextFieldState();
}

class _SimpleAuthTextFieldState extends State<SimpleAuthTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        style: const TextStyle(color: Colors.black),
        controller: widget.myController,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
