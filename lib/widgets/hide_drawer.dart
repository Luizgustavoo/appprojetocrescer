import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ShimmerDrawerHeader(), // Cabeçalho com efeito shimmer
          ShimmerMenuItem(), // Item do menu com efeito shimmer
          ShimmerMenuItem(),
          ShimmerMenuItem(),
          ShimmerMenuItem(),
          ShimmerMenuItem(),
          ShimmerMenuItem(),
          ShimmerMenuItem(),
          ShimmerMenuItem(),
          ShimmerMenuItem(),
          ShimmerMenuItem(),
        ],
      ),
    );
  }
}

class ShimmerDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      child: SizedBox(
        height: size.height * .3,
        child: DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 150,
                height: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }
}

class ShimmerMenuItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: ListTile(
        leading: Icon(
          Icons.menu,
          color: Colors.grey,
        ),
        title: Container(
          width: 100,
          height: 16,
          color: Colors.grey,
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }
}

class ShimmerListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 20,
        ),
        title: Container(
          width: 100,
          height: 16,
          color: Colors.grey,
        ),
        subtitle: Container(
          width: 150,
          height: 12,
          color: Colors.grey,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
      ),
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
    );
  }
}
