import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class CustomRichTextWidget extends StatelessWidget {
  final String label;
  final String value;

  CustomRichTextWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Ubuntu',
          color: CustomColors.azul,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
