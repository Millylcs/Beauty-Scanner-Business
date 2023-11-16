class Endereco {
  final String logradouro;
  final String bairro;
  final String complemento;
  final String localidade;
  final String uf;
  final String porExtenso;

  Endereco(
    this.logradouro,
    this.bairro,
    this.localidade,
    this.complemento,
    this.uf,
    this.porExtenso
  );

  Map<String, dynamic> toMap() {
    return {
      'logradouro': logradouro,
      'bairro': bairro,
      'localidade': localidade,
      'complemento': complemento,
      'uf': uf,
      'porExtenso': porExtenso
    };
  }
}
