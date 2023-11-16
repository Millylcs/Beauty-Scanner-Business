import 'package:beauty_scanner_business/Endereco.dart';

import 'endereco_model.dart';
import 'cep_repository.dart';
import 'cep_repository_impl.dart';
import 'package:flutter/material.dart';

class PesquisaEndereco extends StatefulWidget {
  List<Endereco> enderecos;
  PesquisaEndereco({super.key, required this.enderecos});

  @override
  State<PesquisaEndereco> createState() => _PesquisaEnderecoState();
}

class _PesquisaEnderecoState extends State<PesquisaEndereco> {
  TextEditingController logradouroController = TextEditingController();
  TextEditingController localidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  List<Endereco> enderecos = [];
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;

  bool loading = false;
  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    cepEC.dispose();
  }

  SizedBox margem = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    enderecos = widget.enderecos;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Buscar endereço pelo CEP',
          style: TextStyle(color: Color(0xFF5800DD)),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 300,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: TextFormField(
                    controller: cepEC,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'CEP obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5800DD),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () async {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          try {
                            setState(() {
                              loading = true;
                            });
                            final endereco =
                                await cepRepository.getCep(cepEC.text);

                            setState(() {
                              loading = false;
                              enderecoModel = endereco;
                              if (endereco.logradouro != '') {
                                String extenso =
                                    '${enderecoModel?.logradouro}, ${enderecoModel?.bairro}. ${enderecoModel?.localidade}/${enderecoModel?.uf} - ${enderecoModel?.complemento} ${enderecoModel?.cep}';
                                localidadeController.text =
                                    '${endereco.localidade}/${endereco.uf}';
                                logradouroController.text = endereco.logradouro;
                                bairroController.text = endereco.bairro;
                                complementoController.text =
                                    endereco.complemento;
                                Endereco end = Endereco(
                                    logradouroController.text,
                                    bairroController.text,
                                    localidadeController.text,
                                    complementoController.text,
                                    endereco.uf,
                                    extenso);
                                bool contem = enderecos.contains(end);
                                if(!contem)
                                {
                                  enderecos.add(end);
                                }
                                }
                              }
                            );
                          } catch (e) {
                            setState(() {
                              loading = false;
                              enderecoModel = null;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Erro ao buscar endereço')),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Buscar CEP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: loading,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Color(0xFF5800DD),
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                      hintText: 'Logradouro',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 0.5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 0.5))),
                    ),
                    controller: logradouroController,
                  ),
                ),
                margem,
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                      hintText: 'Bairro',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 0.5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 0.5))),
                    ),
                    controller: bairroController,
                  ),
                ),
                margem,
                SizedBox(
                    width: 350,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                        hintText: 'Localidade',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(227, 227, 227, 0.5))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                color: Color.fromRGBO(227, 227, 227, 0.5))),
                      ),
                      controller: localidadeController,
                    )),
                margem,
                margem,
                SizedBox(
                  width: 350,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(227, 227, 227, 0.5),
                      hintText: 'Complemento',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 0.5))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(227, 227, 227, 0.5))),
                    ),
                    controller: complementoController,
                  ),
                ),
                margem,
                Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                    child: Column(
                        children: enderecos.map((end) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  Container(
                                      margin: const EdgeInsets.only(top: 2),
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(250, 60, 200, 220),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 22,
                                              margin: const EdgeInsets.only(
                                                  left: 5, right: 5),
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.wrong_location,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    enderecos.remove(end);
                                                  });
                                                },
                                              ),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: 5, right: 15),
                                                child: Text(end.porExtenso)),
                                          ]))
                                ])
                              ]);
                        }).toList())),
                margem,
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'lista': enderecos, // Passa a lista Alergias de volta
                    });
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
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
