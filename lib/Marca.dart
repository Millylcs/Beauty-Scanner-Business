// ignore_for_file: file_names
import 'package:beauty_scanner_business/Endereco.dart';

class Marca {
  final String nome;
  List<String> produtos = [];
  List<Endereco> enderecos = [];
  final String descricao;
  final String imagem;
  Marca(this.nome, this.produtos, this.descricao, this.imagem);
}
