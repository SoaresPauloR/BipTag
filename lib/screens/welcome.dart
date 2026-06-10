import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 3),

              // Logo Biptag
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF282828),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'BT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Título
              const Text(
                'BipTag',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF282828),
                ),
              ),
              const SizedBox(height: 16),

              // Subtítulo
              const Text(
                'Acompanhe e proteja o que mais\nimporta. Sua gestão patrimonial, de\nforma simples e segura na palma da\nmão.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 4),

              // Tracinhos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF282828),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 12,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Botão Entrar
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF282828),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              // Botão Criar Conta
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF282828),
                  side: BorderSide(color: Colors.grey.shade400),
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Criar conta',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
