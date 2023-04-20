import 'package:flutter/material.dart';
import 'package:projetocrescer/widgets/fale_conosco_tile.dart';

class FaleConosco extends StatefulWidget {
  @override
  State<FaleConosco> createState() => _FaleConoscoState();
}

class _FaleConoscoState extends State<FaleConosco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FALE CONOSCO'),
      ),
      body: ListView(
        children: [
          FaleConoscoTile(
            icon: Icons.whatsapp,
            color: Colors.green,
            title: 'data2',
            subtitle: 'data',
            ontap: () {},
          ),
        ],
      ),
    );
  }
}
