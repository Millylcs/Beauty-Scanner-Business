import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Produto.dart';
import 'Usuario.dart';
import 'VisuProduto.dart';
class Produtos extends StatefulWidget {
  Produtos(
      {super.key});

  @override
  State<Produtos> createState() => _ProdutosState();
}

Future<List<Produto>> searchRecomend() async {
  final QuerySnapshot produtos = await FirebaseFirestore.instance
      .collection('produtos')
      .get();

  List<Produto> listProdutos = [];
  for (QueryDocumentSnapshot produtoDoc in produtos.docs) {
    final String nome = produtoDoc.get('nome');
    final int nota = produtoDoc.get('nota').toInt();
    final String quantidade = produtoDoc.get('quantidade');
    final String alerta = produtoDoc.get('alerta');
    final String descricao = produtoDoc.get('descricao');
    final String marca = produtoDoc.get('marca');
    String imagem = produtoDoc.get('url');
    String codigo = produtoDoc.get('codigo');

    Produto produto = Produto(
        nome, nota, quantidade, imagem, alerta, descricao, marca, [], codigo);
    listProdutos.add(produto);
  }
  return listProdutos;
}

  List<String> allItems = [];
  List<Produto> items = [];
  var searchHistory = [];
  String selected = '';
  final TextEditingController searchController = TextEditingController();
 // ignore: non_constant_identifier_names

 

class _ProdutosState extends State<Produtos> {
  var ingredientes = [];
  var produtos = <Produto>[];

  void pesquisaProdutos() async {
    produtos = await searchRecomend();
    print(produtos.toString());
    setState(() {});
  }

   @override
  void initState() {
    super.initState();
    searchController.addListener(queryListenner);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListenner);
    searchController.dispose();
    super.dispose();
  }

  void queryListenner() {
    // ignore: unnecessary_null_comparison
    if (searchController.text != "" || searchController.text != null) {
      search(searchController.text);
    }
  }

  int index = 0;
  void search(String query) async {
    if (query.isEmpty) {
      items = List.empty();
    } else {
      List<Produto> produtosEncontrados = await searchRecomend();
      items = produtosEncontrados;
    }
  }

  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    //pesquisaProdutos();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [            
            Container(
                    margin: const EdgeInsets.only(top: 40, left: 25, right: 25),
                    child: SearchAnchor(
                        searchController: controller,
                        isFullScreen: false,
                        viewBackgroundColor: Colors.white,
                        suggestionsBuilder:
                            (BuildContext context, searchController) {
                          search(searchController.text);
                          if (items.isNotEmpty) {
                            return List<Widget>.generate(items.length, (index) {
                              final Produto item = items[index];
                              return ListTile(
                                title: Text(item.nome),
                                onTap: () {
                                  print('a pesquisar: ${item.nome}');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => VisuProduto(produto: item)));
                                  // searchController.closeView('');
                                  //setState(() {});
                                },
                              );
                            });
                          } else {
                            return List<Widget>.generate(1, (index) {
                              return const ListTile(
                                title: Text(" "),
                              );
                            });
                          }
                        },
                        builder: (BuildContext context,
                            SearchController controller) {
                          return SearchBar(
                              controller: controller,
                              onTap: () {
                                controller.openView();
                              },
                              onChanged: (_) {
                                //searchController.openView();
                                controller.openView();
                                //setState(() {});
                              },
                              leading: const IconButton(
                                  onPressed: null, icon: Icon(Icons.search)),
                              // trailing: [
                              //   IconButton(
                              //       onPressed: () {}, icon: const Icon(Icons.filter_list))
                              // ],
                              textStyle:
                                  MaterialStateProperty.resolveWith<TextStyle?>(
                                      ((states) {
                                return const TextStyle(fontSize: 17);
                              })),
                              hintText: 'Pesquisar produto',
                              hintStyle:
                                  MaterialStateProperty.resolveWith<TextStyle?>(
                                      ((states) {
                                return const TextStyle(
                                    color: Color.fromARGB(255, 154, 151, 151),
                                    fontSize: 17);
                              })));
                        })),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                'Produtos',
                style: const TextStyle(color: Color(0xFF5800dd), fontSize: 20),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 15),
                alignment: Alignment.topLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Wrap(
                      direction: Axis
                          .horizontal, // Define a direção da "embalagem" (horizontal no seu caso)
                      spacing: 8.0, // Espaçamento horizontal entre os itens
                      runSpacing:
                          8.0, // Espaçamento vertical entre as linhas de itens
                      children: produtos.map((currItem) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (c) => VisuProduto(
                                        produto: currItem)));
                          },
                          child: Container(
                            width: 180,
                            height: 200,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF1c1c1c),
                                  blurRadius: 2,
                                  spreadRadius: 0.3,
                                  offset: Offset(
                                    1.5,
                                    1.5,
                                  ),
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Stack(
                              children: [
                                Container(
                                  width: 150,
                                  height: 150,
                                  alignment: Alignment.topCenter,
                                  child: Stack(children: [
                                    Image(
                                      image: NetworkImage(currItem.imagem),
                                      height: 400,
                                      alignment: Alignment.topCenter,
                                    ),
                                    Positioned(
                                      bottom: 110,
                                      left: 80,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 13,
                                            right: 13,
                                            top: 5,
                                            bottom: 5),
                                        margin: const EdgeInsets.only(
                                            top: 40, left: 30, right: 10),
                                        decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              stops: [0.18, 0.6],
                                              colors: [
                                                Color(0xFF4b0194),
                                                Color(0xFF5500dd)
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50.0))),
                                        child: Text('${currItem.nota}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ),
                                    )
                                  ]),
                                ),
                                Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(left: 15, top:140),
                                        child: SizedBox(
                                            width: 180,
                                            child: Text(currItem.nome))),
                                    Container(
                                      margin: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          Text(currItem.marca),
                                          Text(', ${currItem.quantidade} ml')
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      );
                      }).toList(),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
