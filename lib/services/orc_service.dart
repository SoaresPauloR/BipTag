import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class OcrService {
  // URL Github Gist
  static const String _mockApiUrl =
      'https://gist.githubusercontent.com/MathLaborde/d980f193c2d839c89024589d617c91bc/raw/a8400599d9fac786fb80f3144f2a79270ea4a4c3/nota_fiscal_biptag.json';

  // Função que simula o envio da foto e o retorno dos dados
  static Future<Map<String, String>?> scanReceipt() async {
    try {
      // Simulamos o tempo de upload da foto
      await Future.delayed(const Duration(seconds: 2));
      // Fazemos a requisição HTTP real para a URL
      final response = await http.get(Uri.parse(_mockApiUrl));
      // Requisição deu certo
      if (response.statusCode == 200) {
        // Converte a string (JSON) para (Map)
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          return {
            'name': data['data']['name'],
            'description': data['data']['description'],
            'category': data['data']['category'],
          };
        }
      }
      return null;
    } catch (e) {
      debugPrint('Erro de conexão: $e');
      return null;
    }
  }
}
