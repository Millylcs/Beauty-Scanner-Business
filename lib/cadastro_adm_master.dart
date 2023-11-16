import 'package:flutter/material.dart';

class CadastroAdm extends StatefulWidget {
  const CadastroAdm({
    Key? key,
  }) : super(key: key);
  @override
  State<CadastroAdm> createState() => _CadastroAdmState();
}

class _CadastroAdmState extends State<CadastroAdm> {
  bool _switchValue = false;
  TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _confirmarPasswordController = TextEditingController();
TextEditingController _nomeEmpresaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 25,
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,
                    color: Color.fromRGBO(88, 0, 221, 1))),
          ),
          Positioned(
            top: 100,
            right: 65,
            child: Text(
              'Beauty Scanner',
              style: TextStyle(
                color: Color.fromRGBO(88, 0, 221, 1),
                fontSize: 37,
              ),
            ),
          ),
          //nome
          Positioned(
            top: 170,
            right: 25,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Nome',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //data de nascimento
          Positioned(
            top: 230,
            right: 25,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Data de Nascimento',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //cpf
          Positioned(
            top: 290,
            right: 25,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' CPF',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //email
          Positioned(
            top: 350,
            right: 25,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Email',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //senha
          Positioned(
            top: 410,
            right: 25,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Senha',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          //confirmar senha
          Positioned(
            top: 470,
            right: 25,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 350,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                    hintText: ' Confirmar senha',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(227, 227, 227, 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 340,
            right: 150,
            child: Row(
              children: [
                Text(
                  'Administrador Master',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Defina o negrito
                    fontSize: 16, // Defina o tamanho da fonte
                  ),
                ),
                Switch(
                  value: _switchValue,
                  onChanged: (bool newValue) {
                    setState(() {
                      _switchValue = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 620,
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica quando o botão é pressionado
                    bool isPasswordValid(String senha) {
                    bool hasUppercase = false;
                    bool hasLowercase = false;
                    bool hasNumber = false;

                    for (int i = 0; i < senha.length; i++) {
                      if (senha[i].contains(RegExp(r'[A-Z]'))) {
                        hasUppercase = true;
                      } else if (senha[i].contains(RegExp(r'[a-z]'))) {
                        hasLowercase = true;
                      } else if (senha[i].contains(RegExp(r'[0-9]'))) {
                        hasNumber = true;
                      }
                    }

                    return hasUppercase && hasLowercase && hasNumber;
                  }

                  // if (senha != confirmarSenha)
                  //   print("Senhas não estão iguais!");
                  // else if (senha.length < 8)
                  //   print(
                  //       "Senha menor que 8 caracteres. Defina uma senha com mais de 8 caracteres, pelo menos uma letra maiúscula e um número.");
                  // else if (!isPasswordValid(senha))
                  //   print(
                  //       "Defina uma senha com mais de 8 caracteres, com pelo menos uma letra maiúscula, uma minúscula e um número.");
                  // else
                  //   registerUser(
                  //       email, senha, nome, alergias, recomendacoes, context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(88, 0, 221, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  child: const Text('    Cadastrar    '),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
