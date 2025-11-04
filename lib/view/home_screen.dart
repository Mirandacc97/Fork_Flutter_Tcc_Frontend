import 'package:flutter/material.dart';
import 'package:tcc1/view/vendas_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  // 3. MÉTODO OBRIGATÓRIO QUE CRIA A CLASSE DE ESTADO
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// 4. NOVA CLASSE DE ESTADO QUE CONTÉM TODA A LÓGICA
class _HomeScreenState extends State<HomeScreen> {

  // 5. MÉTODO BUILD (AGORA DENTRO DA CLASSE DE ESTADO)
  @override
  Widget build(BuildContext context) {
    // Adicionado 'const' aqui
    const Color backgroundColor = Color(0xFF1E1E1E);
    const Color primaryColor = Color(0xFFF98D4B);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          // Adicionado 'const' aqui
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Todos os métodos auxiliares são chamados a partir daqui
              _buildHeader(primaryColor),
              const SizedBox(height: 24), // Adicionado 'const'
              _buildSearchBar(),
              const SizedBox(height: 24), // Adicionado 'const'
              _buildInfoCard(
                primaryColor: primaryColor,
                title1: 'item para ser mostrado',
                value1: '5', // <-- VALOR FIXO
                title2: 'dados avalidos',
                value2: '15,000', // <-- VALOR FIXO
              ),
              const SizedBox(height: 16), // Adicionado 'const'
              _buildInfoCard(
                primaryColor: primaryColor,
                title1: 'Item para ser mostrado',
                value1: '1', // <-- VALOR FIXO
                title2: 'Dados',
                value2: '3,000', // <-- VALOR FIXO
              ),
              const SizedBox(height: 24), // Adicionado 'const'
              _buildActionButtons(primaryColor),
              const SizedBox(height: 24), // Adicionado 'const'
              _buildFinanceButton(context, primaryColor), // 'context' está disponível aqui
              const SizedBox(height: 24), // Adicionado 'const'
            ],
          ),
        ),
      ),
    );
  }

  // --- TODOS OS MÉTODOS AUXILIARES AGORA ESTÃO AQUI DENTRO ---

  Widget _buildHeader(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Adicionado 'const'
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C), // Adicionado 'const'
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10), // Adicionado 'const'
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 36), // Adicionado 'const'
              ),
              const SizedBox(width: 16), // Adicionado 'const'
              const Text(
                'OI', // Mantido como "OI"
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const Row( // Adicionado 'const'
            children: [
              Icon(Icons.notifications_none, color: Colors.white, size: 30),
              SizedBox(width: 16),
              Icon(Icons.menu, color: Colors.white, size: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Adicionado 'const'
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField( // Adicionado 'const'
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Pesquise aqui',
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required Color primaryColor,
    required String title1,
    required String value1,
    required String title2,
    required String value2,
  }) {
    return Container(
      padding: const EdgeInsets.all(20), // Adicionado 'const'
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCardSection(title: title1, value: value1),
              _buildCardSection(title: title2, value: value2, alignRight: true),
            ],
          ),
          const SizedBox(height: 10), // Adicionado 'const'
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(Icons.cloud_upload_outlined, color: Colors.white.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSection({required String title, required String value, bool alignRight = false}) {
    return Column(
      crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14), // Adicionado 'const'
        ),
        Text(
          value,
          style: const TextStyle( // Adicionado 'const'
            color: Colors.white,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Apenas widgets de exibição, sem Gestures
        _buildSmallButton(
          primaryColor,
          Icons.person_outline,
          'item para ser mostrado',
          '1',
        ),
        _buildSmallButton(
          primaryColor,
          Icons.people_outline,
          'item para ser mostrado',
          '2.000',
        ),
        _buildSmallButton(
          primaryColor,
          Icons.people_alt_outlined,
          'item para ser mostrado',
          '1',
        ),
      ],
    );
  }

  Widget _buildSmallButton(Color color, IconData icon, String text1, String text2) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12), // Adicionado 'const'
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 4), // Adicionado 'const'
          Text(text1, style: const TextStyle(color: Colors.white, fontSize: 8)), // Adicionado 'const'
          Text(text2, style: const TextStyle(color: Colors.white, fontSize: 8)), // Adicionado 'const'
        ],
      ),
    );
  }

  Widget _buildFinanceButton(BuildContext context, Color primaryColor) {
    return ElevatedButton(
      onPressed: () {
        // Navegação para a tela de Vendas
        Navigator.push(
          context,
          // Adicionado 'const' aqui
          MaterialPageRoute(builder: (context) => const VendasScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16), // Adicionado 'const'
      ),
      child: const Icon( // Adicionado 'const'
          Icons.monetization_on,
          color: Colors.white,
          size: 30
      ),
    );
  }
}

