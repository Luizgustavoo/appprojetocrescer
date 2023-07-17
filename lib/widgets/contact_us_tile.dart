import 'package:flutter/material.dart';

import 'package:projetocrescer/utils/custom_colors.dart';

class ContactUsTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final Function? ontap;

  ContactUsTile({
    this.ontap,
    this.color,
    this.title,
    this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5, left: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 3,
        child: ListTile(
          contentPadding:
              EdgeInsets.only(top: 15, bottom: 10, right: 10, left: 10),
          onTap: () => ontap,
          leading: Icon(
            icon,
            color: color,
            size: 40,
          ),
          title: Text(
            title!,
            style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * 15,
              fontFamily: 'Montserrat',
            ),
          ),
          subtitle: Text(
            subtitle!,
            style: TextStyle(
              fontSize: MediaQuery.of(context).textScaleFactor * 12,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w500,
            ),
          ),
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
