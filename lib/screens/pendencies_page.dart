import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_pendencies.dart';
import 'package:projetocrescer/models/class_login.dart';
import 'package:projetocrescer/widgets/pendencies_item.dart';
import 'package:provider/provider.dart';
import 'package:simple_annimated_staggered/simple_annimated_staggered.dart';

class PendenciesPage extends StatefulWidget {
  @override
  _PendenciesPageState createState() => _PendenciesPageState();
}

class _PendenciesPageState extends State<PendenciesPage> {
  bool _isLoading = true;

  Future<void> loadPendencias(BuildContext context) async {
    final matricula = Provider.of<Login>(context, listen: false).matricula;
    if (matricula != null) {
      await Provider.of<Pendencias>(context, listen: false)
          .loadPendencias(matricula);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPendencias(context);
  }

  Widget _buildPendencyItem(BuildContext context, int index) {
    final pendenciasData = Provider.of<Pendencias>(context);
    final pendencias = pendenciasData.items;
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: Duration(milliseconds: 100),
      child: ScaleAnimation(
        duration: Duration(milliseconds: 500),
        child: PendenciesItem(pendencias[index]),
      ),
    );
  }

  Widget _buildPendenciesList(BuildContext context) {
    return Expanded(
      child: Consumer<Pendencias>(
        builder: (context, pendenciasData, _) => pendenciasData.itemsCount <= 0
            ? Center(
                child: Text(
                  'Nenhuma pendência encontrada! \nParabéns. 💙',
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
                itemBuilder: (ctx, i) => _buildPendencyItem(context, i),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  _buildPendenciesList(context),
                ],
              ),
            ),
    );
  }
}
