import 'package:beauty_scanner_business/resul_cep.dart';
import 'package:http/http.dart';

class ViaCepService {
  var client = new Client();

  Future<ResultCep> fetchCep({required String cep}) async {
    final response = await client.get(Uri(path: 'https://viacep.com.br/ws/$cep/json/'));
    if (response.statusCode == 200) {
      return ResultCep.fromJson(response.body);
    } else {
      throw Exception('Requisição inválida!');
    }
  }
}
