import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projetocrescer/utils/custom_colors.dart';

class AgendarTile extends StatelessWidget {
  final String? data;
  final String? cafe;
  final String? nomeAula1;
  final String? almoco;
  final String? nomeAula2;

  const AgendarTile({
    Key? key,
    this.data,
    this.cafe,
    this.nomeAula1,
    this.almoco,
    this.nomeAula2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
      child: Card(
        elevation: 3,
        child: ExpansionTile(
          collapsedTextColor: Colors.black,
          textColor: CustomColors.azul,
          iconColor: CustomColors.azul,
          childrenPadding: EdgeInsets.all(10),
          title: Text(data!),
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(cafe!),
                      SizedBox(
                        height: 10,
                      ),
                      Text(almoco!),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: CustomColors.amarelo,
                    thickness: 3,
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.trashCan,
                          size: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.trashCan,
                          size: 20,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
