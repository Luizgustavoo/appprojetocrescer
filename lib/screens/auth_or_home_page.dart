import 'package:flutter/material.dart';
import 'package:projetocrescer/main.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/screens/home_page.dart';
import 'package:provider/provider.dart';

class AuthOrHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Login login = Provider.of(context);
    return FutureBuilder(
      future: login.tryAutologin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(child: Text("Ocorreu um erro!"));
        } else {
          return login.isAuth ? HomePage() : IndexPage();
        }
      },
    );
  }
}
