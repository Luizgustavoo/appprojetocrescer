import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_announcement.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/utils/custom_colors.dart';
import 'package:projetocrescer/widgets/notices_item.dart';
import 'package:provider/provider.dart';

class NoticesPage extends StatefulWidget {
  @override
  _NoticesPageState createState() => _NoticesPageState();
}

class _NoticesPageState extends State<NoticesPage> {
  bool _isLoading = true;

  Future<void> loadComunicados(BuildContext context) {
    // final usuarioData = Provider.of<Login>(context, listen: false);

    return Provider.of<Comunicados>(context, listen: false)
        .loadComunicados(Provider.of<Login>(context, listen: false).matricula!)
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
                        return NoticesItem(comunicados[i]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
