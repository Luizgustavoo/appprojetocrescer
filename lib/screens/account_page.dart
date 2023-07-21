import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:projetocrescer/models/class_account.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/constants.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/utils/formater.dart';
import 'package:projetocrescer/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<Perfis>(context, listen: false).loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    var providerFoto = Provider.of<Login>(context).foto.toString();

    bool fotoExiste = false;

    final String foto = Constants.URL_FOTOS + providerFoto;

    if (providerFoto != 'null') {
      fotoExiste = true;
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<Perfis>(
          builder: (context, perfis, _) {
            if (perfis.items.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final perfil = perfis.items[0];

              return ListView(
                children: [
                  Column(
                    children: [
                      PhotoWidget(
                          size: size, fotoExiste: fotoExiste, foto: foto),
                      SizedBox(height: 10),
                      Divider(),
                      DataWidget(perfil: perfil)
                    ],
                  ),
                ],
              );
            }
          },
        ));
  }
}

class PhotoWidget extends StatelessWidget {
  const PhotoWidget({
    super.key,
    required this.size,
    required this.fotoExiste,
    required this.foto,
  });

  final Size size;
  final bool fotoExiste;
  final String foto;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          color: CustomColors.amarelo,
          elevation: 1,
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              child: CircleAvatar(
                radius: size.width * .15,
                backgroundImage: fotoExiste
                    ? NetworkImage(
                        foto,
                      )
                    : AssetImage('images/avatar.png') as ImageProvider,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DataWidget extends StatelessWidget {
  const DataWidget({
    super.key,
    required this.perfil,
  });

  final Perfil perfil;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'DADOS CADASTRAIS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'NOME',
              data: perfil.nomePessoa!,
              iconData: FontAwesomeIcons.solidUser),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'INSTITUIÇÃO',
              data: perfil.descricaoInstituicao!,
              iconData: FontAwesomeIcons.house),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'PERIODO',
              data: perfil.periodoMatricula!.toUpperCase(),
              iconData: FontAwesomeIcons.solidSun),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'DATA DE NASC',
              data: DateFormat('dd/MM/y')
                  .format(DateTime.parse(perfil.nascimentoPessoa!)),
              iconData: FontAwesomeIcons.calendar),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'CELULAR',
              data: Formater.formatarNumeroCelular(perfil.celularPessoa!),
              iconData: FontAwesomeIcons.phone),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'RG',
              data: Formater.formatarRG(perfil.rgPessoa!),
              iconData: FontAwesomeIcons.solidAddressCard),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'CPF',
              data: Formater.formatarCPF(perfil.cpfPessoa!),
              iconData: FontAwesomeIcons.solidAddressCard),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'E-MAIL',
              data: perfil.emailPessoa!,
              iconData: FontAwesomeIcons.solidAddressCard),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'CEP',
              data: Formater.formatarCEP(perfil.cepPessoa!),
              iconData: FontAwesomeIcons.locationDot),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'ENDEREÇO',
              data: perfil.enderecoPessoa!,
              iconData: FontAwesomeIcons.locationDot),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'BAIRRO',
              data: perfil.bairroPessoa!,
              iconData: FontAwesomeIcons.locationDot),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'Nº',
              data: perfil.numeroEnderecoPessoa!,
              iconData: FontAwesomeIcons.n),
          SizedBox(height: 5),
          Divider(),
          Text(
            'DADOS ESCOLARES',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
            ),
          ),
          SizedBox(height: 5),
          CustomTextField(
              labelText: 'Nº',
              data: perfil.nomeEscola!,
              iconData: FontAwesomeIcons.school),
          SizedBox(height: 5),
          // CustomTextField(
          //     labelText: 'Nº',
          //     data: perfil.telefoneEscola!,
          //     iconData: FontAwesomeIcons.phone),
        ],
      ),
    );
  }
}
