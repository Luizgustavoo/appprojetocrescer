import 'package:flutter/material.dart';

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
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        onTap: ontap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageUrl!,
                width: MediaQuery.of(context).size.height * .075,
              ),
              SizedBox(height: 7),
              Text(
                title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Color(0xFF130B3B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
