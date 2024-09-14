import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_list_smit/Utils/colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  double? buttonWidth;
  double? buttonHeight;
  String buttonText;
  Color? buttonColor;
  Color? textColor;
  double? buttonRadius;
  double? buttonFontSize;
  FontWeight? buttonFontWeight;
  Function onPressed;
  final double? horizontalPadding;
  final double? verticalPadding;
  final bool isLoading;

  CustomButton(
      {super.key,
      required this.buttonText,
      required this.onPressed,
      this.buttonColor,
      this.buttonFontSize,
      this.buttonFontWeight,
      this.buttonHeight,
      this.buttonRadius,
      this.buttonWidth,
      this.textColor,
      this.horizontalPadding,
      this.verticalPadding,
      this.isLoading = false});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.buttonWidth ?? 20,
      height: widget.buttonHeight ?? 5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.buttonColor ?? appcolor,
          padding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPadding ?? 5,
              vertical: widget.verticalPadding ?? 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.buttonRadius ?? 10.0),
            ),
          ),
        ),
        onPressed: () => widget.onPressed(),
        child: widget.isLoading
            ? CircularProgressIndicator(
                color: appcolor,
                backgroundColor: Colors.white,
              )
            : Text(
                widget.buttonText,
                style: GoogleFonts.poppins(
                  color: widget.textColor ?? Colors.white,
                  fontSize: widget.buttonFontSize?.toDouble() ?? 12,
                  fontWeight: widget.buttonFontWeight ?? FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
