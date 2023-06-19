import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class MenuHomePageScreen extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final VoidCallback? ontap;
  final String? imageUrl;

  MenuHomePageScreen({
    @required this.title,
    @required this.subTitle,
    @required this.ontap,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: InkWell(
        splashColor: CustomColors.azul,
        borderRadius: BorderRadius.circular(10),
        onTap: ontap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageUrl!,
                width: MediaQuery.of(context).size.height * .09,
              ),
              SizedBox(height: 7),
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Color(0xFF130B3B),
                ),
              ),
              SizedBox(height: 4),
              Text(
                subTitle!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  overflow: TextOverflow.clip,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
