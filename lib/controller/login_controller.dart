import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tcc1/view/home_screen.dart';

class LoginControllor {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // O método 'logar' agora é async para aguardar a resposta da API
  void login(BuildContext context) async {
    final email = emailController.text;
    final senha = senhaController.text;

    // Use 10.0.2.2 para acessar o localhost da máquina host (onde o backend roda)
    // a partir do Emulador Android.
    // Se estiver rodando em web ou iOS, pode usar 'localhost:8080'.
    final url = Uri.parse('http://10.0.2.2:8080/login'); // A porta 8080 é o padrão do backend

    try {
      final resposta = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'login': email,
          'senha': senha,
        }),
      );

      // O backend retorna 200 em sucesso ou 403 (Forbidden) se a senha estiver errada
      if (resposta.statusCode == 200) {
        // Sucesso na autenticação
        // final dados = jsonDecode(resposta.body);
        // (Aqui você guardaria o token JWT que o backend retorna)

        // Navega para a HomeScreen SOMENTE se o login for bem-sucedido
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        // Exibir falha ao usuário (Ex: Senha incorreta)
        print('Erro no login: ${resposta.statusCode} | ${resposta.body}');
        // (Implementar um SnackBar ou Dialog de erro aqui)
      }
    } catch (e) {
      // Captura erros de conexão (Ex: Servidor backend desligado)
      print('Erro de conexão: $e');
      // (Implementar um SnackBar ou Dialog de erro de conexão aqui)
    }
  }

  void senhaEsquecido() {
    print("usuario esqueceu a senha");
  }

  void dispose() {
    emailController.dispose();
    senhaController.dispose();
  }
}