import 'package:flutter/material.dart';
import 'package:tcc1/view/scanner_screen.dart';

class VendasScreen extends StatefulWidget {
  const VendasScreen({super.key});

  @override
  State<VendasScreen> createState() => _VendasScreenState();
}

class _VendasScreenState extends State<VendasScreen> {
  // --- VARIÁVEIS DE ESTADO ---
  int _itensAdicionados = 0;
  double _subTotal = 0.0;

  // 1. VARIÁVEIS DE PAGAMENTO (Adicionado)
  final List<String> _tiposPagamento = ['Dinheiro', 'PIX', 'Crédito', 'Débito'];
  String _pagamentoSelecionado = 'Dinheiro';

  // --- SIMULAÇÃO DE BANCO DE DADOS ---
  final Map<String, Map<String, dynamic>> _produtosMock = {
    '7891091017120': {'nome': 'São Braza Familia 400g', 'preco': 5.70},
    '7892840819507': {'nome': 'toddy 370g', 'preco': 11.90},
    '7898403782387': {'nome': 'Betania 1L', 'preco': 4.59},
  };

  Map<String, dynamic>? _buscarProduto(String codigo) {
    return _produtosMock[codigo] ??
        {'nome': 'Produto Genérico ($codigo)', 'preco': 10.00};
  }

  // --- LÓGICA DO SCANNER ---
  void _abrirScanner() async {
    final String? codigoDeBarras = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const ScannerScreen()),
    );

    if (codigoDeBarras != null && codigoDeBarras.isNotEmpty) {
      final produtoEncontrado = _buscarProduto(codigoDeBarras);
      if (mounted && produtoEncontrado != null) {
        _mostrarDialogoConfirmacao(produtoEncontrado);
      }
    }
  }

  // --- POPUP DE CONFIRMAÇÃO ---
  Future<void> _mostrarDialogoConfirmacao(Map<String, dynamic> produto) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Confirmar Produto',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Icon(Icons.shopping_bag, size: 50, color: Color(0xFFF98D4B)),
                const SizedBox(height: 16),
                Text(produto['nome'],
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text('R\$ ${produto['preco'].toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Color(0xFFF98D4B),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF98D4B)),
              child: const Text('Adicionar', style: TextStyle(color: Colors.white)),
              onPressed: () {
                setState(() {
                  _itensAdicionados++;
                  _subTotal += produto['preco'];
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${produto['nome']} adicionado!'),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF1E1E1E);
    const Color primaryColor = Color(0xFFF98D4B);
    const Color buttonColor = Color(0xFF0D0D0D);
    const Color textColor = Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Vendas',
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: textColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BOTÕES NO TOPO (Igual ao original) ---
            _buildVendasButton(
              color: primaryColor,
              text: 'clique para bipar o produto',
              icon: Icons.qr_code_scanner,
              onTap: _abrirScanner,
            ),
            const SizedBox(height: 24),

            _buildVendasButton(
              color: primaryColor,
              text: 'Finalizar a vendas',
              icon: Icons.shopping_cart_checkout,
              onTap: () {
                if (_itensAdicionados == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Nenhum item adicionado.')));
                  return;
                }
                // Exibe o resumo final com o pagamento selecionado
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Venda Finalizada"),
                    content: Text(
                        "Total: R\$ ${_subTotal.toStringAsFixed(2)}\nPagamento: $_pagamentoSelecionado"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            setState(() {
                              _itensAdicionados = 0;
                              _subTotal = 0.0;
                              _pagamentoSelecionado = 'Dinheiro';
                            });
                          },
                          child: const Text("OK"))
                    ],
                  ),
                );
              },
            ),

            const Spacer(),

            // --- SELETOR DE PAGAMENTO (Inserido aqui de forma discreta) ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _pagamentoSelecionado,
                  dropdownColor: const Color(0xFF2C2C2C),
                  icon: const Icon(Icons.arrow_drop_down, color: primaryColor),
                  isExpanded: true,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  items: _tiposPagamento.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _pagamentoSelecionado = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- RESUMO DA VENDA (Igual ao original) ---
            _buildSummaryRow(
                title: 'itens adicionados:', value: _itensAdicionados.toString()),
            const SizedBox(height: 16),
            _buildSummaryRow(
                title: 'SubTotal:', value: 'R\$ ${_subTotal.toStringAsFixed(2)}'),

            const SizedBox(height: 32),

            // --- BOTÃO CANCELAR (Igual ao original) ---
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text('cancelar venda',
                    style: TextStyle(color: textColor, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar dos botões (Mantido igual)
  Widget _buildVendasButton({
    required Color color,
    required String text,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
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
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }

  // Widget auxiliar do resumo (Mantido igual)
  Widget _buildSummaryRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}