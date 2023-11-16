import 'package:beauty_scanner_business/NovoProdutoAdm.dart';
import 'package:flutter/material.dart';

class Solicitacoes extends StatelessWidget {
  const Solicitacoes({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: const SolicitacoesState(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 50,
              fontWeight: FontWeight.normal,
            ),
          ),
        ));
  }
}

class SolicitacoesState extends StatefulWidget {
  const SolicitacoesState({super.key});

  @override
  State<SolicitacoesState> createState() => _SolicitacoesStateState();
}

class Solicitacao {
  Solicitacao(this.tipo, this.id_tipo, this.id);
  String tipo;
  int id;
  int id_tipo;
}

class _SolicitacoesStateState extends State<SolicitacoesState> {
  var solicitacoes = <Solicitacao>[];
  void preencher() {
    solicitacoes.add(Solicitacao('Novo Produto', 1, 23));
    solicitacoes.add(Solicitacao('Alteração Produto', 2, 9));
    solicitacoes.add(Solicitacao('Novo Produto', 1, 23));
    solicitacoes.add(Solicitacao('Alteração Produto', 2, 9));
    // solicitacoes.add(Solicitacao('Exclusão Produto', 3, 45));
    // solicitacoes.add(Solicitacao('Nova Marca', 4, 21));
    // solicitacoes.add(Solicitacao('Alteração Marca', 5, 32));
    // solicitacoes.add(Solicitacao('Exclusão Marca', 6, 15));
  }

  String img = "";
  setImage(int idFoto) {
    switch (idFoto) {
      case 1:
        img = "assets/produtos.png";               
        break;
      case 2:
        img = "assets/produtos.png";
        break;
      case 3:
        img = "assets/produtos.png";
        break;
      case 4:
        img = "assets/marcas.png";
        break;
      case 5:
        img = "assets/marcas.png";
        break;
      case 6:
        img = "assets/marcas.png";
        break;
    }
  }

  setPage(int idFoto) {
    switch (idFoto) {
      case 1: 
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NovoProdutoAdm(tipo: 'Novo Produto',),
          ),
        );      
        break;
      case 2:
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NovoProdutoAdm(tipo: 'Aleteração de Produto'),
          ),
        ); 
        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    preencher();
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitações', style: TextStyle(color: Color(0xFF5800DD), fontSize: 30),), centerTitle: true,),
        body: Stack(children: [      
      Container(
        margin: EdgeInsets.only(top: 100, left: 35, right: 35),
        //color: Colors.blueGrey,
        child: ListView.builder(
          itemCount: solicitacoes.length,
          itemBuilder: (context, index) {
            Solicitacao currItem = solicitacoes[index];
            setImage(currItem.id_tipo);

            return ListTile(
                title: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image(
                          image: AssetImage(img),
                          height: 50,
                        ),
                        Container(
                            width: 200,
                            margin: EdgeInsets.only(left: 20),
                            child: Text('${currItem.tipo}',
                                style: TextStyle(fontSize: 20))),
                      ],
                    ),
                    Container(
                      color: Color(0xFF5500dd),
                      width: 220,
                      height: 0.5,
                      margin: EdgeInsets.only(top: 0, left: 25),
                    )
                  ],
                ),
                onTap: () {setPage(currItem.id_tipo);}
                    );
          },
        ),
      ),
    ]));
  }
}
