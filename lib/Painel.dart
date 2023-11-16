import 'Marcas.dart';
import 'NovaMarca.dart';
import 'Produtos.dart';
import 'login.dart';
import 'package:flutter/material.dart';

import 'novoProduto.dart';

class Painel extends StatefulWidget {
  const Painel({super.key});

  @override
  _PainelState createState() => _PainelState();
}

class _PainelState extends State<Painel> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Beauty Scanner', style: TextStyle(color: Color(0xFF5800DD), fontSize: 40),), elevation: 0, centerTitle: true, backgroundColor: Colors.white,),
      body: Center(child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row( mainAxisSize: MainAxisSize.min,
            children: [
            GestureDetector(child: Container(margin: const EdgeInsets.all(5), alignment: Alignment.center,width: 150, height: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: const Color.fromARGB(255, 248, 212, 224)), child: const Text('Novo Produto', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),)), onTap: () {Navigator.push(
                      context, MaterialPageRoute(builder: (c) => const NovoProduto()));},),
            GestureDetector(child: Container(margin: const EdgeInsets.all(5), alignment: Alignment.center,width: 150, height: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: const Color.fromARGB(255, 249, 248, 211)), child: const Text('Nova Marca', style: TextStyle(color: Color.fromARGB(255, 233, 192, 30), fontWeight: FontWeight.bold),)), onTap: () {Navigator.push(
                      context, MaterialPageRoute(builder: (c) => const NovaMarca()));},),
          ]),
          Row(mainAxisSize: MainAxisSize.min,
            children: [
            GestureDetector(child: Container(margin: const EdgeInsets.all(5), alignment: Alignment.center,width: 150, height: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: const Color.fromARGB(255, 217, 235, 248)), child: const Text('Produtos', style: TextStyle(color: Color.fromARGB(255, 30, 165, 233), fontWeight: FontWeight.bold),)), onTap: () {Navigator.push(
                      context, MaterialPageRoute(builder: (c) => Produtos()));},),
            GestureDetector(child: Container(margin: const EdgeInsets.all(5), alignment: Alignment.center,width: 150, height: 150, decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: const Color.fromARGB(255, 247, 201, 241)), child: const Text('Marcas', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),)), onTap: () {Navigator.push(
                      context, MaterialPageRoute(builder: (c) =>  Marcas()));},),
          ]),
        ],
      ),)
    );
  }
}