import 'package:flutter/material.dart';
import 'package:tcc1/view/home_screen.dart';

class LoginControllor{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  // 2. FUNÇÃO DE LOGIN AGORA RECEBE O CONTEXT
  void login(BuildContext context){
    final email = emailController.text;
    final senha = senhaController.text;

    // 3. LÓGICA DE NAVEGAÇÃO
    // (Aqui você pode adicionar verificação de email/senha)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void senhaEsquecido(){
    print("usuario esqueceu a senha");

  }
  void dispose(){
    emailController.dispose();
    senhaController.dispose();
  }
}

