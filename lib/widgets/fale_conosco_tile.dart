import 'package:flutter/material.dart';

import 'package:projetocrescer/utils/custom_colors.dart';

class FaleConoscoTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Function ontap;

  FaleConoscoTile({
    this.ontap,
    this.color,
    this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: ListTile(
          onTap: ontap,
          leading: Icon(
            icon,
            color: color,
            size: 40,
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 30,
            color: CustomColors.amarelo,
          ),
        ),
      ),
    );
  }
}
