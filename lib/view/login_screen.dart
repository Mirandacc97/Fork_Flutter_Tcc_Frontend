import 'package:flutter/material.dart';
import 'package:tcc1/controller/login_controller.dart'; // Certifique-se que 'erp1' é o nome do seu projeto

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginControllor loginController = LoginControllor();

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24.0),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'ERP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 48),

                _buildTextField(
                  controller: loginController.emailController,
                  label: 'Email',
                  hint: 'digite seu email',
                ),
                const SizedBox(height: 24),

                _buildTextField(
                  controller: loginController.senhaController,
                  label: 'Senha',
                  hint: 'digite sua senha',
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: loginController.senhaEsquecido,
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3F51B5),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // Chama o login(context) do controller
                  onPressed: () => loginController.login(context),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller, // Usa o controller passado
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white54),
            filled: true,
            fillColor: const Color(0xFF3E3E3E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

