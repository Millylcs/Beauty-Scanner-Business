import 'package:flutter/material.dart';
import 'Produto.dart';

// ignore: must_be_immutable
class NovoProdutoAdm extends StatefulWidget {
  String tipo = '';
   NovoProdutoAdm({super.key, required this.tipo});

  @override
  State<NovoProdutoAdm> createState() => _NovoProdutoAdmState();
}

class _NovoProdutoAdmState extends State<NovoProdutoAdm> {
 Color roxo = const Color(0xFF5800DD);
 SizedBox espaco = const SizedBox(width: 30);
 String imagem = 'assets/testeProduto.png';
 String nome = 'Cleasing Oil';
 String marca = 'Bioré';
 String descricao = 'pi\npi\npi\npo\npo\npo';
 String codigo = '13560998';
  void trocarImagem() {
    //logica de carregar uma nova imagem para o produto 
  }

  @override
  Widget build(BuildContext context) {    
    Container titulo (String txt)
    {
      return Container(margin: const EdgeInsets.only(left:20),alignment: Alignment.topLeft,child: Text(txt, style: TextStyle(color: roxo, fontSize: 18),));
    }
    Container dado (String txt, int lines, String tipo){
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top:15, bottom:15, left:20),
        margin: const EdgeInsets.only(left:15, right: 15),
        decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(50)),
        child: TextField(controller: TextEditingController(text: txt), decoration: null, maxLines: lines, onChanged: (value) {
                          switch (tipo) {
                            case 'nome':
                                nome = value;
                              break;
                            case 'marca':
                                marca = value;
                              break;
                            case 'descricao':
                                descricao = value;
                              break;
                            case 'codigo':
                                codigo = value;
                              break;
                          }                                                    
                        },)
      );
    }
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,title: Center(child: Row(mainAxisSize: MainAxisSize.min,children: [IconButton(icon: Icon(Icons.arrow_back_ios, color: roxo,), onPressed: () {Navigator.pop(context);},), espaco,Text(widget.tipo, style: TextStyle(color: roxo),), espaco],)),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
              child: Center(
          child: Column(children: [
            titulo('Imagem'),
            Container(alignment: Alignment.center,margin: const EdgeInsets.all(10), color: Colors.grey[50], child: Stack(
              children: [
                Image(image: AssetImage(imagem), height: 180,),
                Positioned(bottom:0, left:10, child: IconButton(onPressed: () {trocarImagem();}, icon: Icon(Icons.download, color: roxo,)))
              ],
            )),          
            titulo('Nome'),
            dado(nome, 1, 'nome'), 
            titulo('Marca'),
            dado(marca, 1, 'marca'),
            titulo('Descrição'),
            dado(descricao, 10, 'descricao'),
            titulo('Código de Barras'),
            dado(codigo, 1, 'codigo'), 
            Row(children: [
              titulo('Ingredientes'),
              //botao adicionar
            ],),
            //lista de ingredientes
            Row(children: [
              titulo('Sugestão de Tags'),
              //botao adicionar
            ],),
            //lista de tags
            ElevatedButton(onPressed: () {
              showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Teste Navegação'),
                              content: Text('$nome\n$marca\n$codigo\n$descricao'),
                            );
                          },
                        );
            }, style: ElevatedButton.styleFrom(backgroundColor: roxo), child: const Text('Aprovar', style: TextStyle(color: Colors.white, fontSize: 20),),)
          ])
        ),
      ),
    );
  }
}
