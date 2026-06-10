import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF212121)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Créditos',
          style: TextStyle(
            color: Color(0xFF212121),
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[300],
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 32.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo Circular
                    Center(
                      child: Container(
                        width: 72,
                        height: 72,
                        decoration: const BoxDecoration(
                          color: Color(0xFF222222),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'BT',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Título e Versão
                    const Center(
                      child: Text(
                        'BipTag',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF212121),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: Text(
                        'Versão 1.0.0 — MVP',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Conteúdo da Equipe
                    Text(
                      'EQUIPE',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Color(0xFFE0E0E0)),
                    _buildNameRow('Matheus Laborde'),
                    const Divider(height: 1, color: Color(0xFFE0E0E0)),
                    _buildNameRow('Narayana Moreira'),
                    const Divider(height: 1, color: Color(0xFFE0E0E0)),
                    _buildNameRow('Paulo Soares'),
                    const Divider(height: 1, color: Color(0xFFE0E0E0)),
                    _buildNameRow('Pedro Rosa'),
                    const Divider(height: 1, color: Color(0xFFE0E0E0)),
                    _buildNameRow('Victor Lang'),
                    const Divider(height: 1, color: Color(0xFFE0E0E0)),

                    const SizedBox(height: 32),

                    // Conteúdo Tecnologias
                    Text(
                      'TECNOLOGIAS',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Flutter · Dart · Supabase',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Rodapé da FIAP
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                bottom: 24.0,
                top: 16.0,
              ),
              color: const Color(0xFFF9F9F9),
              child: Text(
                'FIAP — Sistemas de Informação 2026',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para gerar a linha com o nome de cada membro
  Widget _buildNameRow(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF424242),
        ),
      ),
    );
  }
}
