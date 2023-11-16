import 'package:beauty_scanner_business/Endereco.dart';
import 'package:beauty_scanner_business/PesquiaEndereco.dart';
import 'package:beauty_scanner_business/pesquisa_ingrediente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'menu_navegacao.dart';

class NovaMarca extends StatefulWidget {
  const NovaMarca({
    super.key,
  });

  @override
  State<NovaMarca> createState() => _NovaMarcaState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmarPasswordController = TextEditingController();
TextEditingController _nomeEmpresaController = TextEditingController();
TextEditingController _urlEmpresaController = TextEditingController();
TextEditingController _cnpjController = TextEditingController();
TextEditingController _telefoneController = TextEditingController();

Future<void> registerUser(String email, String password, String nome,
    String url, int cnpj, int phone, BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // O usuário foi criado com sucesso
    print('Empresa registrada com sucesso: ${userCredential.user?.uid}');

    // Agora, vamos adicionar as informações adicionais ao Firestore
    await FirebaseFirestore.instance
        .collection('companys')
        .doc(userCredential.user?.uid)
        .set({
      'tipo': "empresa",
      'nome': nome,
      'url': url,
      'cnpj': cnpj,
      'phone': phone
    });
    // Redirecione o usuário para a tela principal ou qualquer outra tela apropriada
    // ignore: use_build_context_synchronously
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MenuNavegacao()));
  } catch (e) {
    // Tratar erros de registro
    print('Erro de registro: $e');
  }
}

class _NovaMarcaState extends State<NovaMarca> {
  SizedBox espaco = const SizedBox(width: 30);
  Color roxo = const Color(0xFF5500DD);
  SizedBox margem = const SizedBox(height: 15);
  List<Endereco> Enderecos = [];
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: roxo,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                espaco,
                Text(
                  'Nova Marca',
                  style: TextStyle(color: roxo, fontSize: 30),
                ),
                espaco,
                espaco
              ],
            ))),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Container(
          alignment: Alignment.topCenter,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Nome da empresa',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                  ),
                  controller: _nomeEmpresaController,
                ),
              ),

              // //CNPJ
              // margem,
              // SizedBox(
              //   width: 350,
              //   height: 50,
              //   child: TextField(
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
              //       hintText: ' CNPJ ',
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           borderSide: const BorderSide(
              //               color: Color.fromRGBO(227, 227, 227, 0.5))),
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           borderSide: const BorderSide(
              //               color: Color.fromRGBO(227, 227, 227, 0.5))),
              //     ),
              //     controller: _cnpjController,
              //   ),
              // ),

              //Telefone
              margem,
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Telefone',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                  ),
                  controller: _telefoneController,
                ),
              ),

              //Site da empresa
              margem,
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Site da empresa ',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                  ),
                  controller: _urlEmpresaController,
                ),
              ),

              //email
              margem,
              SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(227, 227, 227, 0.5))),
                  ),
                  controller: _emailController,
                ),
              ),

              // //senha
              // margem,
              // SizedBox(
              //   width: 350,
              //   height: 50,
              //   child: TextField(
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
              //       hintText: 'Senha',
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           borderSide: const BorderSide(
              //               color: Color.fromRGBO(227, 227, 227, 0.5))),
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           borderSide: const BorderSide(
              //               color: Color.fromRGBO(227, 227, 227, 0.5))),
              //     ),
              //     controller: _passwordController,
              //   ),
              // ),

              // //confirmar senha
              // margem,
              // SizedBox(
              //   width: 350,
              //   height: 50,
              //   child: TextField(
              //     decoration: InputDecoration(
              //       filled: true,
              //       fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
              //       hintText: 'Confirmar senha',
              //       enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           borderSide: const BorderSide(
              //               color: Color.fromRGBO(227, 227, 227, 0.5))),
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30.0),
              //           borderSide: const BorderSide(
              //               color: Color.fromRGBO(227, 227, 227, 0.5))),
              //     ),
              //     controller: _confirmarPasswordController,
              //   ),
              // ),

              //texto Loja Fisica
              margem,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Loja Física',
                      style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left:5),
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color.fromRGBO(229, 227, 227, 1),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 15,
                        color: Color.fromRGBO(97, 95, 95, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PesquisaEndereco(
                                enderecos: Enderecos),
                          ),
                        ).then((retorno) {
                          if (retorno != null) {
                            setState(() {
                              Enderecos = retorno['lista'];
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                  child: Column(
                      children: Enderecos.map((end) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 2),
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(
                                          250,60,200,
                                          220),
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [                                          
                                          Container(
                                            width: 22,
                                            margin:
                                                const EdgeInsets.only(left: 5, right: 5),
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.wrong_location,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  Enderecos.remove(end);
                                                });
                                              },
                                            ),
                                          ),
                                          Container(margin: EdgeInsets.only(left:5, right: 15),child: Text(end.porExtenso)),                                          
                                        ]))
                              ])
                            ]);
                      }).toList())),
                      margem, margem,
                      ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(backgroundColor: roxo, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))), child: const Text('Cadastrar', style: TextStyle(color: Colors.white, fontSize: 15),),)
            ])));
  }
}
