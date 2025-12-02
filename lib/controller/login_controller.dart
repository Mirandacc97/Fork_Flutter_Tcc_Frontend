import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tcc1/view/home_screen.dart';

class LoginController {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  void login(BuildContext context) async {
    final url = Uri.parse('http://10.0.2.2:8080/login');

    try {
      final resposta = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8',},
        body: jsonEncode({
          'login': loginController.text,
          'senha': senhaController.text,
        }),
      ).timeout(const Duration(seconds: 2));

      if (resposta.statusCode == 200) {
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro no login: ${resposta.statusCode} | ${resposta.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro de conexão: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void senhaEsquecido() {
    print("Em desenvolvimento");
  }

  void dispose() {
    loginController.dispose();
    senhaController.dispose();
  }
}