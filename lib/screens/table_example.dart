import 'package:flutter/material.dart';

class TableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('BOLETIM DO ALUNO'),
        ),
        // drawer: AppDrawer(),
        body: ListView(children: <Widget>[
          // Container(
          //   margin: EdgeInsets.all(10),
          //   height: 50,
          //   child: Center(
          //       child: Text(
          //     '2021',
          //     style: TextStyle(
          //         fontSize: 25,
          //         fontWeight: FontWeight.bold,
          //         color: Theme.of(context).accentColor),
          //   )),
          // ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(
                    label: Text('#',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('1º T.',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('2º T.',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('3º T.',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Total',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.book_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'PORTUGUÊS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.calculate_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'MATEMÁTICA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.people_outline),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CIDADANIA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('E', style: TextStyle(fontSize: 18))),
                  DataCell(Text('E', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.emoji_flags),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'INGLÊS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    
                    Row(
                      children: [
                        Icon(Icons.sports_soccer),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ED. FÍSICA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.music_note),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'FLAUTA DOCE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.escalator_warning),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'AUTO CONHEC.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    
                    Row(
                      children: [
                        Icon(Icons.emoji_symbols),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CANTO',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),

                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.sports_kabaddi_outlined),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CAPOEIRA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.art_track),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ARTE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.emoji_people_sharp),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CORAL',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.engineering),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ROBÓTICA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.computer),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'INFORMÁTICA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.food_bank),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'CHOCOLATE',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                    Row(
                      children: [
                        Icon(Icons.queue_music),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'FANFARRA',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
                DataRow(cells: [
                  DataCell(
                   Row(
                      children: [
                        Icon(Icons.theater_comedy),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'TEATRO',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  DataCell(Text('S', style: TextStyle(fontSize: 18))),
                  DataCell(Text('I',
                      style: TextStyle(fontSize: 18, color: Colors.red))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                  DataCell(Text('B', style: TextStyle(fontSize: 18))),
                ]),
              ],
            ),
          ),
        ]));
  }
}
