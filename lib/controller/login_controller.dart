import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tcc1/view/home_screen.dart'; //

class LoginController {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void login(BuildContext context) async {
    // 10.0.2.2 é para emulador Android. Se for iOS use localhost.
    final url = Uri.parse('http://localhost:8080/login');

    try {
      final resposta = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'login': loginController.text,
          'senha': senhaController.text,
        }),
      ).timeout(const Duration(seconds: 5));

      print("Status: ${resposta.statusCode}");
      print("Body: ${resposta.body}");

      if (resposta.statusCode == 200) {
        final Map<String, dynamic> dados = jsonDecode(resposta.body);

        // CORREÇÃO CRÍTICA: Verificar se o backend disse "success: true"
        if (dados['success'] == true) {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        } else {
          // Se success: false, mostra o erro na tela
          _showSnack(context, dados['message'] ?? 'Falha no login', Colors.red);
        }
      } else {
        _showSnack(context, 'Erro HTTP: ${resposta.statusCode}', Colors.orange);
      }
    } catch (e) {
      print(e);
      _showSnack(context, 'Erro de Conexão: Verifique se o Server Dart está rodando.', Colors.red);
    }
  }

  void _showSnack(BuildContext context, String msg, Color color) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: color),
      );
    }
  }

  void senhaEsquecido() {}

  void dispose() {
    loginController.dispose();
    senhaController.dispose();
  }
}