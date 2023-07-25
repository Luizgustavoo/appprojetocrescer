import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback ontap;
  final bool seta;

  CustomListTile(this.icon, this.title, this.ontap, this.seta);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 2, 2, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey.shade300,
        ))),
        child: ListTile(
          onTap: ontap,
          leading: Icon(
            icon,
            color: CustomColors.azul,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: CustomColors.amarelo,
          ),
        ),
      ),
    );
  }
}
