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

  Future<void> loadComunicados(BuildContext context) async {
    final matricula = Provider.of<Login>(context, listen: false).matricula;
    if (matricula != null) {
      await Provider.of<Comunicados>(context, listen: false)
          .loadComunicados(matricula);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadComunicados(context);
  }

  Widget _buildNoticesItem(BuildContext context, int index) {
    final comunicadosData = Provider.of<Comunicados>(context);
    final comunicados = comunicadosData.items;
    return NoticesItem(comunicados[index]);
  }

  Widget build(BuildContext context) {
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
              child: Consumer<Comunicados>(
                builder: (context, comunicadosData, _) => Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: comunicadosData.itemsCount,
                        itemBuilder: _buildNoticesItem,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
