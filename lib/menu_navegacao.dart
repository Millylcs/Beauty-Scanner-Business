// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
//import 'package:tcc_flutter_5/login.dart';
//import 'package:beauty_scanner_business';

import 'Painel.dart';
import 'PerfilADM.dart';
import 'solicitacoes.dart';

class MenuNavegacao extends StatefulWidget {
  const MenuNavegacao({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuNavegacao> createState() => _MenuNavegacaoState();
}

class _MenuNavegacaoState extends State<MenuNavegacao> {
  int _indiceAtual = 1;

  static //const
      List<Widget> _widgetOptions = <Widget>[
    PerfilADM(),
    Painel(),
    Solicitacoes()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_indiceAtual),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indiceAtual,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_sharp),
                label: '',
                backgroundColor: Color.fromRGBO(88, 0, 221, 1)),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard),
                label: '',
                backgroundColor: Color.fromRGBO(88, 0, 221, 1)),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active),
                label: '',
                backgroundColor: Color.fromRGBO(88, 0, 221, 1)),
          ],
          selectedItemColor: Color.fromARGB(255, 182, 134, 240),
          backgroundColor: const Color.fromRGBO(88, 0, 221, 1)),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}
