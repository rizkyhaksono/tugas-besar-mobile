import 'package:flutter/material.dart';
import 'package:push_puzzle/constants/resources.dart';

class CreditView extends StatelessWidget {
  CreditView({super.key});

  final List<Contributor> contributors = [
    Contributor("Muhammad Rizky Haksono", "202110370311325"),
    Contributor("Rafli Kharisma Akbar", "202110370311402"),
    Contributor("Geraldi Nathan Tommy Saputra", "202110370311351"),
    Contributor("Alviya Laela", "202110370311400"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contributors'),
      ),
      body: DataTable(
        columns: [
          DataColumn(
              label: Text(
            'Name',
            style: TextStyle(fontFamily: Resources.font.primaryFont),
          )),
          DataColumn(
              label: Text(
            'NIM',
            style: TextStyle(fontFamily: Resources.font.primaryFont),
          )),
        ],
        rows: contributors.map((contributor) {
          return DataRow(cells: [
            DataCell(Text(contributor.name)),
            DataCell(Text(contributor.email)),
          ]);
        }).toList(),
      ),
    );
  }
}

class Contributor {
  final String name;
  final String email;

  Contributor(this.name, this.email);
}
