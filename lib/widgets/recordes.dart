import 'package:cobrinha/pages/recordes_page_desafiante.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../pages/recordes_page_normal.dart';
import '../theme.dart';

class Recordes extends StatefulWidget {
  const Recordes({Key? key}) : super(key: key);

  @override
  State<Recordes> createState() => _RecordesState();
}

class _RecordesState extends State<Recordes> {
  showRecordesNormal() async {
      await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => RecordesPageNormal(),
      ),
    );
  }

  showRecordesDesafiante() async {
      await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const RecordesPageDesafiante(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              
              padding: EdgeInsets.all(5),
              child: Text(
                'RECORDE',
                
                style: TextStyle(
                  
                  color: cobrinhaTheme.color,
                  fontSize: 22,
                ),
              ),
            ),
            ListTile(
              title: const Text('Normal',
              style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: showRecordesNormal,
            ),
            ListTile(
              title: const Text(
                'Desafiante',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: showRecordesDesafiante,
            )
          ],
        ),
      ),
    );
  }
}
