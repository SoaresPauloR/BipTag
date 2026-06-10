import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class RfidService {
  // URL Github Gist
  static const String _mockApiUrl =
      'https://gist.githubusercontent.com/MathLaborde/d23f5e5143039da3a69f5ec97a8832aa/raw/580afefffe24c14eb479de4d96dcfcad87d805d2/rfid_biptag.json';

  // Função que simula a leitura NFC/RFID dos objetos
  static Future<Map<String, dynamic>?> scanTag() async {
    try {
      // Simula o tempo do celular fazer a leitura física do RFID
      await Future.delayed(const Duration(seconds: 1));
      // Fazemos a requisição HTTP real para a URL
      final response = await http.get(Uri.parse(_mockApiUrl));
      // Requisição deu certo
      if (response.statusCode == 200) {
        // Converte a string (JSON) para (Map)
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          return data['tag_data'];
        }
      }
      return null;
    } catch (e) {
      debugPrint('Erro na leitura RFID: $e');
      return null;
    }
  }
}
