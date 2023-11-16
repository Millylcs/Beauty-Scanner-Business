import 'dart:convert';

class EnderecoModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;

  EnderecoModel({
    required this.uf,
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
  });

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento,
      'uf': uf,
      'bairro': bairro,
      'localidade': localidade,
    };
  }

  factory EnderecoModel.fromMap(Map<String, dynamic> map) {
    return EnderecoModel(
      cep: map['cep'] ?? '',
      logradouro: map['logradouro'] ?? '',
      complemento: map[''] ?? '',
      uf: map['uf'] ?? '',
      bairro: map['bairro'] ?? '',
      localidade: map['localidade'] ?? '',
    );
  }

  factory EnderecoModel.fromJson(String json) =>
      EnderecoModel.fromMap(jsonDecode(json));
}
