import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
  const ShowCaseView(
      {super.key,
      required this.globalKey,
      required this.title,
      required this.description,
      required this.child,
      required this.border});

  final GlobalKey globalKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder border;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      titlePadding: EdgeInsets.all(5),
      descriptionPadding: EdgeInsets.all(5),
      showArrow: true,
      descriptionAlignment: TextAlign.justify,
      titleAlignment: TextAlign.center,
      blurValue: 2,
      titleTextStyle: TextStyle(
        color: CustomColors.azul,
        fontSize: 17,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
        letterSpacing: .5,
      ),
      descTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 15,
        fontFamily: 'Ubuntu',
        letterSpacing: .1,
      ),
      title: title,
      key: globalKey,
      description: description,
      child: child,
    );
  }
}
