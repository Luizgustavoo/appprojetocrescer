import 'package:flutter/material.dart';
import 'package:projetocrescer/models/class_classroom.dart';
import 'package:provider/provider.dart';

class StudentSchedulePage extends StatefulWidget {
  @override
  State<StudentSchedulePage> createState() => _StudentSchedulePageState();
}

class _StudentSchedulePageState extends State<StudentSchedulePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AulasDias>(context, listen: false).loadAulas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HORÁRIO SEMANAL'),
      ),
      body: Center(
        child: Consumer<AulasDias>(
          builder: (context, provider, _) {
            if (provider.diasOficinas.isEmpty) {
              // Dados ainda estão sendo carregados
              return CircularProgressIndicator();
            } else {
              // Dados carregados, você pode exibi-los aqui
              return ListView.builder(
                itemCount: provider.diasOficinas.length,
                itemBuilder: (context, index) {
                  final diaOficina = provider.diasOficinas[index];
                  return _buildExpansionTile(diaOficina);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildExpansionTile(DiaOficina diaOficina) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          childrenPadding: EdgeInsets.all(8.0),
          title: Text(
            diaOficina.idDia.toUpperCase() + '- FEIRA',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 19,
              fontFamily: 'Montserrat',
            ),
          ),
          children: [
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        '1ª AULA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: Colors.amber.shade500,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        '2ª AULA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: Colors.green.shade500,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        '3ª AULA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          color: Colors.blue.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: Text(
                        diaOficina.oficinas.length >= 1
                            ? diaOficina.oficinas[0]
                            : '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        diaOficina.oficinas.length >= 2
                            ? diaOficina.oficinas[1]
                            : '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Text(
                        diaOficina.oficinas.length >= 3
                            ? diaOficina.oficinas[2]
                            : '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
