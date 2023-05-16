import 'package:flutter/material.dart';

class ClipPathCustom extends StatelessWidget {
  const ClipPathCustom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BorderCurveClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .45,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFEBAE1F),
                Color(0xFFE6E047),
              ],
            )),
          ),
        ),
        ClipPath(
          clipper: CurveClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .38,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE6E047),
                Color(0xFFEBAE1F),
              ],
            )),
          ),
        ),
        Positioned(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ClipPath(
                clipper: BorderBottomDecClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB(255, 4, 76, 110),
                      Color(0XFFd7f1fa),
                    ],
                  )),
                ),
              )),
        ),
        Positioned(
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ClipPath(
                clipper: BottomDecClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0XFF4da9fa),
                      Color(0xFF130B3B),
                    ],
                  )),
                ),
              )),
        ),
      ],
    );
  }
}

class BorderBottomDecClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.cubicTo(size.width * .20, size.height * 0.20, size.width * .75,
        size.height * .75, size.width, 0);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BottomDecClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.cubicTo(size.width * .25, size.height * 0.25, size.width * .85,
        size.height * .85, size.width, 0);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class BorderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.cubicTo(
      size.width * .75,
      size.height * .65,
      size.width * .15,
      size.height * .15,
      0,
      size.height,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.cubicTo(
      size.width * .8,
      size.height * .6,
      size.width * .20,
      size.height * .20,
      0,
      size.height,
    );
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
