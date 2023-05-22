import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HideHome extends StatefulWidget {
  @override
  State<HideHome> createState() => _HideHomeState();
}

class _HideHomeState extends State<HideHome>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.easeInOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: 1,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            padding: EdgeInsets.all(8),
            children: List.generate(8, (index) {
              return Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            color: Colors.red,
            width: size.width,
            height: animation.value * 20,
            child: Text(
              'Conecte-se a uma rede (Wifi/Móvel)',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
