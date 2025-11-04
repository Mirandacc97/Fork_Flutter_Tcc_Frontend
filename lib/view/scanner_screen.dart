import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  // Controller para o scanner
  final MobileScannerController controller = MobileScannerController(
    // Configurações do scanner (opcional, mas recomendado)
    detectionSpeed: DetectionSpeed.normal, // Rápida detecção
    facing: CameraFacing.back, // Câmera traseira
  );

  bool _isScanInProgress = false; // Trava para evitar scans múltiplos

  @override
  void dispose() {
    controller.dispose(); // Limpa o controller ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Produto'),
        backgroundColor: const Color(0xFFF98D4B), // Cor laranja
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.white), // Seta de voltar branca
      ),
      body: Stack(
        children: [
          // 1. O Widget da Câmera
          MobileScanner(
            controller: controller,
            // 2. A função que é chamada quando um código é detectado
            onDetect: (capture) {
              if (_isScanInProgress) return; // Se já está processando, ignora

              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty) {
                final String? codigo = barcodes.first.rawValue;

                if (codigo != null) {
                  setState(() {
                    _isScanInProgress = true; // Trava
                  });

                  // 3. Retorna o código para a tela anterior (VendasScreen)
                  Navigator.pop(context, codigo);
                }
              }
            },
          ),

          // 4. (Opcional) Uma sobreposição visual para ajudar o usuário
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

