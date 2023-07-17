import 'package:flutter/material.dart';
import 'package:projetocrescer/widgets/classes_tile.dart';

class StudentSchedulePage extends StatefulWidget {
  @override
  State<StudentSchedulePage> createState() => _StudentSchedulePageState();
}

class _StudentSchedulePageState extends State<StudentSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horario Semanal'.toUpperCase()),
      ),
      body: ListView(
        children: [
          ClassTile(
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