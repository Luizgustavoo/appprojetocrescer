import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String data;
  final IconData iconData;

  CustomTextField({
    required this.labelText,
    required this.data,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: CustomColors.azul,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(
            iconData,
            color: CustomColors.amarelo,
            size: 20,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              data,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Ubuntu',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
