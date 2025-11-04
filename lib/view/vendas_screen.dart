import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tcc1/view/scanner_screen.dart';

// 3. CONVERTER PARA STATEFULWIDGET
class VendasScreen extends StatefulWidget {
  const VendasScreen({super.key});

  @override
  State<VendasScreen> createState() => _VendasScreenState();
}

class _VendasScreenState extends State<VendasScreen> {
  // 4. CRIAR VARIÁVEIS DE ESTADO
  int _itensAdicionados = 15;
  double _subTotal = 150.0;

  // 5. FUNÇÃO PARA ABRIR O SCANNER
  void _abrirScanner() async {
    // Navega para a tela de Scanner e espera um resultado (o código de barras)
    final String? codigoDeBarras = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerScreen(),
      ),
    );

    // 6. PROCESSAR O RESULTADO (apenas um exemplo)
    if (codigoDeBarras != null && codigoDeBarras.isNotEmpty) {
      // Lógica de exemplo:
      // - A cada "bip", adiciona 1 item
      // - A cada "bip", adiciona 12.50 ao subtotal
      setState(() {
        _itensAdicionados++;
        _subTotal += 12.50;
      });

      // Mostra um feedback rápido (opcional)
      if (mounted) { // Verifica se a tela ainda está "viva"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto adicionado: $codigoDeBarras'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    // Cores baseadas na sua imagem e no tema do app
    const Color backgroundColor = Color(0xFF1E1E1E); // Um cinza bem escuro
    const Color primaryColor = Color(0xFFF98D4B); // Laranja
    const Color buttonColor = Color(0xFF0D0D0D); // Preto para o botão
    const Color textColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Vendas',
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: textColor), // Seta de "voltar" branca
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 7. ATUALIZAR O BOTÃO "BIPAR"
            // Botão "clique para bipar o produto"
            _buildVendasButton(
              color: primaryColor,
              text: 'clique para bipar o produto',
              icon: Icons.qr_code_scanner, // Ícone sugerido
              onTap: _abrirScanner, // Adiciona a ação de clique
            ),
            const SizedBox(height: 24),

            // Botão "Finalizar a vendas"
            _buildVendasButton(
              color: primaryColor,
              text: 'Finalizar a vendas',
              icon: Icons.shopping_cart_checkout, // Ícone sugerido
              onTap: () {
                // Lógica de finalização de venda
                print("Finalizando venda...");
                // Aqui você poderia, por exemplo, salvar os dados no Firebase
                // e depois voltar para a HomeScreen
                // Navigator.pop(context);
              },
            ),

            // O Spacer empurra o conteúdo abaixo para o final da tela
            const Spacer(),

            // 8. ATUALIZAR OS TEXTOS DE RESUMO
            // Informações de SubTotal
            _buildSummaryRow(
                title: 'itens adicionados:',
                value: _itensAdicionados.toString() // Usa a variável de estado
            ),
            const SizedBox(height: 16),
            _buildSummaryRow(
                title: 'SubTotal:',
                value: _subTotal.toStringAsFixed(2) // Usa a variável de estado
            ),

            const SizedBox(height: 32),

            // Botão "cancelar venda"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Ação de cancelar
                  Navigator.pop(context); // Volta para a tela anterior
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'cancelar venda',
                  style: TextStyle(color: textColor, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 9. ATUALIZAR O _buildVendasButton para aceitar um 'onTap'
  // Widget auxiliar para os botões de ação (Bipar, Finalizar)
  Widget _buildVendasButton({
    required Color color,
    required String text,
    required IconData icon,
    required VoidCallback onTap, // Manda a função
  }) {
    // Usamos InkWell para dar a área de clique e o efeito visual
    return InkWell(
      onTap: onTap, // Atribui a função ao clique
      borderRadius: BorderRadius.circular(30), // para o efeito visual do clique
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para as linhas de resumo (Itens, SubTotal)
  Widget _buildSummaryRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

