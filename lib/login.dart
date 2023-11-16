import 'cadastro_empresa.dart';
import 'package:flutter/material.dart';
import 'menu_navegacao.dart';
import 'recuperar_email.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Stack(alignment: Alignment.center, children: [
          Positioned(
            top: 100,
            //bottom: 100, // Posição vertical a partir da parte inferior
            //margin: EdgeInsets.only(top:10),
            //right: 60, // Posição horizontal a partir da direita
            child: Image.asset(
              'LogoEstampada_BeautyScanner.png',
              height: 250,
            ),
          ),
          Positioned(
              top: 370,
              //right: 25,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(227, 227, 227, 1),
                        hintText: '  Email',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(227, 227, 227, 1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(227, 227, 227, 1))),
                      ),
                      controller: _emailController,
                    ),
                  ))),
          Positioned(
              top: 430,
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(227, 227, 227, 1),
                        hintText: '  Senha',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(227, 227, 227, 1))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(227, 227, 227, 1))),
                      ),
                      controller: _passwordController,
                    ),
                  ))),
          Positioned(
              top: 600,
              //right: 155,
              child: ElevatedButton(
                onPressed: () async {
                  String email = _emailController.text;
                  String password = _passwordController.text;
                  // LOGIN
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const MenuNavegacao()));
                  //await loginUser(email, password, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(88, 0, 221, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.all(15.0),
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                  ), // Define o tamanho da fonte // Defina o raio de canto desejado
                ),
                child: const Text('    Entrar    '),
              )),
          Positioned(
            top: 680,
            //right: 145,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecuperarEmail()));
              },
              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(
                  color: Color.fromRGBO(24, 24, 25, 1), // Defina a cor do texto
                ),
              ),
            ),
          ),
          Positioned(
            top: 700,
            //right: 185,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuNavegacao()));
              },
              child: const Text(
                'Cadastrar',
                style: TextStyle(
                  color: Color.fromRGBO(88, 0, 221, 1), // Defina a cor do texto
                ),
              ),
            ),
          )
        ]));
  }
}
