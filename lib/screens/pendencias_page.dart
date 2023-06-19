import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_pendencias.dart';
import 'package:projetocrescer/models/login.dart';
import 'package:projetocrescer/widgets/pendecias_item.dart';
import 'package:provider/provider.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class PendeciasPage extends StatefulWidget {
  @override
  _PendeciasPageState createState() => _PendeciasPageState();
}

class _PendeciasPageState extends State<PendeciasPage> {
  bool _isLoading = true;

  Future<void> loadPendencias(BuildContext context) {
    // final usuarioData = Provider.of<Login>(context, listen: false);
    return Provider.of<Pendencias>(context, listen: false)
        .loadPendencias(Provider.of<Login>(context, listen: false).matricula!)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadPendencias(context);
  }

  Widget build(BuildContext context) {
    final pendenciasData = Provider.of<Pendencias>(context);
    final pendencias = pendenciasData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PENDÊNCIAS DO ALUNO',
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => loadPendencias(context),
              child: Column(
                children: [
                  Expanded(
                    child: pendenciasData.itemsCount <= 0
                        ? Center(
                            child: Text(
                              'Nenhuma pendência encontrada! \nParabéns.' +
                                  '💙',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: pendenciasData.itemsCount,
                            itemBuilder: (ctx, i) {
                              return AnimationConfiguration.staggeredList(
                                position: i,
                                duration: Duration(milliseconds: 100),
                                child: ScaleAnimation(
                                  duration: Duration(milliseconds: 500),
                                  child: PendenciasItem(pendencias[i]),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
