import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_comunicado.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/comunicados_item.dart';
import 'package:provider/provider.dart';

class ComunicadosPage extends StatefulWidget {
  @override
  _ComunicadosPageState createState() => _ComunicadosPageState();
}

class _ComunicadosPageState extends State<ComunicadosPage> {
  bool _isLoading = true;

  Future<void> loadComunicados(BuildContext context) {
    // final usuarioData = Provider.of<Login>(context, listen: false);

    return Provider.of<Comunicados>(context, listen: false)
        .loadComunicados(Provider.of<Login>(context, listen: false).matricula)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadComunicados(context);
  }

  Widget build(BuildContext context) {
    final comunicadosData = Provider.of<Comunicados>(context);
    final comunicados = comunicadosData.items;
    return Scaffold(
      backgroundColor: CustomColors.fundo,
      appBar: AppBar(
        title: Text(
          'COMUNICADOS',
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              color: CustomColors.amarelo,
              onRefresh: () => loadComunicados(context),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: comunicadosData.itemsCount,
                      itemBuilder: (ctx, i) {
                        return ComunicadosItem(comunicados[i]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
