import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'Tag.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pesquisa_ingrediente.dart';

Future<String> uploadImageToFirebaseStorage(File? imageFile) async {
  // Crie uma referência para o local no Storage onde deseja armazenar a imagem
  try {
    final Reference storageReference = FirebaseStorage.instance.ref().child(
        'nome_da_pasta/nome_da_imagem.jpg'); // Substitua com o caminho desejado e nome da imagem.

    UploadTask uploadTask = storageReference.putFile(imageFile!);
    await uploadTask;
    final String downloadURL = await storageReference.getDownloadURL();

    return downloadURL;
  } catch (e) {
    print("Erro ao fazer upload da imagem: $e");
    return '';
  }
}

TextEditingController _codigoController = TextEditingController();
List<String> ingredientes = [];
List<String> tags = [];
File? _embalagemController;
File? _rotuloController;

// Defina uma função para cadastrar um novo produto
Future<void> cadastrarProduto(String codigo, String urlRotulo,
    List<String> ingredientes, List<String> tags, int nota) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Crie um novo documento na coleção 'produtos'
    await firestore.collection('solicitacoes').add({
      'codigo': codigo,
      'urlRotulo': urlRotulo,
      'ingredientes': ingredientes,
      'tags': tags,
      'nota': nota
    });

    print('Produto cadastrado com sucesso');
  } catch (e) {
    print('Erro ao cadastrar o produto: $e');
  }
}


class NovoProduto extends StatefulWidget {
  const NovoProduto({super.key});

  @override
  State<NovoProduto> createState() => _NovoProdutoState();
}

class _NovoProdutoState extends State<NovoProduto> {

  Future<void> searchIngredients(String searchTerm) async {
    final QuerySnapshot ingredientes = await FirebaseFirestore.instance
        .collection("ingredientes")
        .where('nome', isEqualTo: searchTerm)
        .get();
    // List<String> teste = [];

    bool exists = false;
    for (DocumentSnapshot i in ingredientes.docs) {
      int note = i.get('nota').toInt();
      if (note <= 5) {
        nota += note * 3;
      } else {
        nota += note;
      }
      quantosIng++;
    }
  }

  Color verdeFundo = const Color(0xFFE3FFEA);
  Color verdeLetra = const Color(0xFF0DD943);
  Color fundo3 = const Color(0xFFDBDBDB);
  Color letra3 = const Color(0xFF787878);


  void setColor3() {
    setState(() {
      fundo3 = verdeFundo;
      letra3 = verdeLetra;
    });
  }

  List<Tag> Ingredientes = [];
  List<Tag> Recomendacoes = [];
  String codigo = '';
  String imgEmbalagem = '';
  bool textScanning = false;
  int nota = 0;
  int quantosIng = 0;

  XFile? imageFile;
  XFile? image;
  String scannedText = "";
  Color roxo = const Color(0xFF5800DD);
  SizedBox espaco = const SizedBox(width: 30);
  SizedBox margem = const SizedBox(height: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                onPressed: () {Navigator.pop(context);},
              ),
              espaco,
              Text(
                'Novo Produto',
                style: TextStyle(color: roxo, fontSize: 30),
              ),
              espaco
            ],
          ))),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            margem,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 8, bottom: 8),
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.18, 0.6],
                        colors: [Color(0xFF4b0194), Color(0xFF5500dd)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: const Text('1',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ),
                SizedBox(
                  width: 230,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFDBDBDB),
                      hintText: 'Código de barras',
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
                    controller: _codigoController,
                    onChanged: (value) {
                      codigo = value;
                    },
                  ),
                ),
              ],
            ),
           
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 8, bottom: 8),
                  margin: const EdgeInsets.only(top: 20, right: 10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.18, 0.6],
                        colors: [Color(0xFF4b0194), Color(0xFF5500dd)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: const Text('2',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ),
                GestureDetector(
                  onTap: () {
                    getRotulo(ImageSource.camera);
                  },
                  child: Container(
                      width: 230,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: fundo3,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.upload,
                              color: Color(0xFF5500DD), size: 25),
                          const SizedBox(width: 10),
                          Text('embalagem',
                              style: TextStyle(fontSize: 18, color: letra3))
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (image != null)
              Image.network(
                image!.path,
                height: 300,
              ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 8, bottom: 8),
                  margin: const EdgeInsets.only(top: 20, right: 10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.18, 0.6],
                        colors: [Color(0xFF4b0194), Color(0xFF5500dd)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: const Text('3',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ),
                GestureDetector(
                  onTap: () {
                    setColor3();
                  },
                  child: Container(
                      width: 230,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Row(
                        children: [
                          Text('Ingredientes',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff5800dd))),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                                    builder: (context) => PesquisaIngrediente(
                                        lista: Ingredientes, tipo: 'ingredientes'),
                                  ),
                                ).then((retorno) {
                                  if (retorno != null) {
                                    setState(() {
                                      Ingredientes = retorno['lista'];
                                    });
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0,
                runSpacing: 8.0,
                children: Ingredientes.map((tag) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(tag.red.toInt(),
                                  tag.green.toInt(), tag.blue.toInt(), 220),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 22,
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: const ShapeDecoration(
                                      color: Colors.red,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 8,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Ingredientes.remove(tag);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(right: 13, left: 5),
                                  child: Text(
                                    tag.descricao,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromRGBO(
                                          tag.red.toInt(),
                                          tag.green.toInt(),
                                          tag.blue.toInt(),
                                          tag.opacity),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 8, bottom: 8),
                  margin: const EdgeInsets.only(top: 20, right: 10),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0.18, 0.6],
                        colors: [Color(0xFF4b0194), Color(0xFF5500dd)],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  child: const Text('5',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25)),
                ),
                GestureDetector(
                  onTap: () {
                    setColor3();
                  },
                  child: Container(
                      width: 230,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      ),
                      child: Row(
                        children: [
                          Text('Sugestão de tags',
                              style: TextStyle(
                                  fontSize: 20, color: Color(0xff5800dd))),
                          Container(
                            margin: const EdgeInsets.only(top: 30),
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                                    builder: (context) => PesquisaIngrediente(
                                        lista: Recomendacoes, tipo: 'tags'),
                                  ),
                                ).then((retorno) {
                                  if (retorno != null) {
                                    setState(() {
                                      Recomendacoes = retorno['lista'];
                                    });
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 5),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0,
                runSpacing: 8.0,
                children: Recomendacoes.map((tag) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(tag.red.toInt(),
                                  tag.green.toInt(), tag.blue.toInt(), 220),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 22,
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    padding: EdgeInsets.zero,
                                    decoration: const ShapeDecoration(
                                      color: Colors.red,
                                      shape: CircleBorder(),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                        size: 8,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          Recomendacoes.remove(tag);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(right: 13, left: 5),
                                  child: Text(
                                    tag.descricao,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Color.fromRGBO(
                                          tag.red.toInt(),
                                          tag.green.toInt(),
                                          tag.blue.toInt(),
                                          tag.opacity),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Lógica de cadastro de produto
                String codigo = _codigoController.text;
                File? rotulo = _rotuloController;

                for (String ing in ingredientes) searchIngredients(ing);
                if(quantosIng > 0)
                  nota = nota ~/ quantosIng;
        
                print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAA " + nota.toString());

                String urlRotulo = await uploadImageToFirebaseStorage(rotulo);
                cadastrarProduto(codigo, urlRotulo, ingredientes, tags, nota);
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
              child: const Text('Cadastrar',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        )),
      ),
    );
  }

  Future<File?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
        source:
            ImageSource.gallery); // Ou ImageSource.camera para usar a câmera
    if (image != null) {
      return File(image.path);
    }
    return null;
  }


  getRotulo(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        image = pickedImage;

        setColor3();
      }
    } catch (e) {
      imageFile = null;
      print('erro na hora de escanear, onde? aqui: ${e.toString()}');
      setState(() {});
    }
  }

  
}
