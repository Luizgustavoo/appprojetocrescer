import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class AlertPage extends StatefulWidget {
  const AlertPage({super.key});

  @override
  State<AlertPage> createState() => _AlertPageState();
}

class _AlertPageState extends State<AlertPage> {
  final List<String> notifications = [
    "Promoção imperdível!",
    "Novos produtos chegaram.",
    "Sua compra foi enviada.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTIFICAÇÕES"),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(),
            title: Text(notifications[index]),
            subtitle: Text("Detalhes da notificação"),
            trailing: Icon(
              Icons.arrow_right_rounded,
              color: CustomColors.amarelo,
              size: 30,
            ),
            onTap: () {
              // Implemente a ação para exibir detalhes da notificação
            },
          );
        },
      ),
    );
  }
}
