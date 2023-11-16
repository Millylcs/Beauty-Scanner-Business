import 'dart:io';
import 'EditarPerfil.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilADM extends StatefulWidget {
  const PerfilADM({super.key});

  @override
  _PerfilADMState createState() => _PerfilADMState();
}

class _PerfilADMState extends State<PerfilADM> {
  String image = '';
  String nome = 'Nome';
  String email = 'email';

  String verficaImagem() {
    if (image.isEmpty || image == '') {
      return 'user.png';
    } else {
      return image;
    }
  }

  SizedBox espaco = const SizedBox(
    width: 30,
  );
  SizedBox margem = const SizedBox(
    height: 30,
  );

  @override
  Widget build(BuildContext context) {
    image = verficaImagem();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          margem,
          margem,
          ClipOval(
              child: Image.asset(
            image,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          )),
          Text(
            nome,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            email,
            style: const TextStyle(color: Color.fromARGB(255, 81, 80, 80), fontWeight: FontWeight.bold),
          ),
          margem,
          const Text(
            'Administrador',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          margem,
          margem,
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const EditarPerfil()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(88, 0, 221, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(
                fontSize: 18.0,
              ), // Define o tamanho da fonte // Defina o raio de canto desejado
            ),
            child: const Text(
              'Editar Perfil',
              style: TextStyle(fontSize: 15),
            ),
          ),
          margem,         
          margem,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.logout, color: Color(0xFF5800DD)),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => const Login()));
                },
              ),
              espaco,
              const Text('Sair',
                  style: TextStyle(
                      color: Color.fromARGB(255, 53, 52, 52), fontSize: 18))
            ],
          )
        ],
      )),
    );
  }
}
