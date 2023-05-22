import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class Aulas extends StatelessWidget {
  final String dia;
  final String aula1;
  final String nomeAula1;
  final String aula2;
  final String nomeAula2;
  final String aula3;
  final String nomeAula3;
  const Aulas({
    Key key,
    this.dia,
    this.aula1,
    this.nomeAula1,
    this.aula2,
    this.nomeAula2,
    this.aula3,
    this.nomeAula3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(10),
        title: Text(dia),
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(aula1),
                    SizedBox(
                      height: 10,
                    ),
                    Text(aula2),
                    SizedBox(
                      height: 10,
                    ),
                    Text(aula3),
                  ],
                ),
                VerticalDivider(
                  color: CustomColors.amarelo,
                  thickness: 3,
                  width: 5,
                ),
                Column(
                  children: [
                    Text(nomeAula1),
                    SizedBox(
                      height: 10,
                    ),
                    Text(nomeAula2),
                    SizedBox(
                      height: 10,
                    ),
                    Text(nomeAula3),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
