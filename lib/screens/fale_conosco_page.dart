import 'package:flutter/material.dart';
import 'package:projetocrescer/utils/custom_links.dart';
import 'package:projetocrescer/widgets/fale_conosco_tile.dart';

class FaleConosco extends StatefulWidget {
  @override
  State<FaleConosco> createState() => _FaleConoscoState();
}

CustomLinks links = CustomLinks();

class _FaleConoscoState extends State<FaleConosco> {
  String phoneNumber = 'tel:433056-0777';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FALE CONOSCO'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
              margin: EdgeInsets.all(8),
              height: 115,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Aqui, o pai ou responsável poderá encontrar facilmente o contato necessário para solucionar qualquer questão relacionada ao Projeto Crescer. Seja para falar com a secretaria, coordenação ou outro setor, todos os números importantes estarão disponíveis nesta tela.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  // backgroundColor: CustomColors.azul,
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Ubuntu',
                ),
              ),
            ),
            FaleConoscoTile(
              icon: Icons.phone,
              color: Colors.green,
              title: 'TELEFONE FIXO PROJETO CRESCER I',
              subtitle: 'Telefone fixo secretaria Projeto \nCrescer I',
              ontap: () async {
                await links.makePhoneCall(phoneNumber);
              },
            ),
            FaleConoscoTile(
              icon: Icons.whatsapp,
              color: Colors.green,
              title: 'COORDENAÇÃO PROJETO CRESCER I',
              subtitle: 'Whatsapp Coordenação Projeto Crescer I',
              ontap: () async {
                links.whatsapp('+5543988194541');
              },
            ),
            FaleConoscoTile(
              icon: Icons.whatsapp,
              color: Colors.green,
              title: 'SECRETÁRIA PED. PROJETO CRESCER I',
              subtitle: 'Whatsapp Secretaria Pedagógica Projeto Crescer I',
              ontap: () async {
                links.whatsapp('+5543988299343');
              },
            ),
            FaleConoscoTile(
              icon: Icons.whatsapp,
              color: Colors.green,
              title: 'SECRETÁRIA PED. PROJETO CRESCER II',
              subtitle: 'Whatsapp Secretaria Pedagógica Projeto Crescer II',
              ontap: () async {
                links.whatsapp('+5543999770311');
              },
            ),
          ],
        ),
      ),
    );
  }
}
