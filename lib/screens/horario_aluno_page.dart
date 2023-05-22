import 'package:flutter/material.dart';
import 'package:projetocrescer/widgets/aulas_tile.dart';

class HorarioPage extends StatefulWidget {
  @override
  State<HorarioPage> createState() => _HorarioPageState();
}

class _HorarioPageState extends State<HorarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horario Semanal'.toUpperCase()),
      ),
      body: ListView(
        children: [
          Aulas(
            dia: 'SEGUNDA-FEIRA',
            aula1: 'AULA 1',
            nomeAula1: 'TEA1',
            aula2: 'AULA 2',
            nomeAula2: 'TEA2',
            aula3: 'AULA 3',
            nomeAula3: 'TEA3',
          ),
        ],
      ),
    );
  }
}
