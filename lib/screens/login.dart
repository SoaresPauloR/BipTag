import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Parte Central com Logo e Formulário
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),

                      // Logo Circular "BT"
                      Center(
                        child: Column(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
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
                            const SizedBox(height: 12),
                            Text(
                              'BipTag',
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF222222),
                                  ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Título "Entrar"
                      Text(
                        'Entrar',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF222222),
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Bem-vindo de volta',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Campo de Email
                      InputFormLocal(
                        label: "Email",
                        hintText: "seu@email.com",
                        controller: _emailController,
                        icon: Icons.email_outlined,
                      ),

                      // Campo de Senha
                      InputFormLocal(
                        label: "Senha",
                        hintText: "••••••••",
                        controller: _passwordController,
                        icon: Icons.lock_outline,
                        obscureText: true,
                      ),

                      const SizedBox(height: 16),

                      // Botão Entrar
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/inventory');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF212121),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Esqueci minha senha
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implementar recuperação de senha
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            foregroundColor: const Color(0xFF212121),
                          ),
                          child: const Text(
                            'Esqueci minha senha',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Rodapé: "Não tem conta? Cadastre-se"
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
                child: Column(
                  children: [
                    const Divider(color: Color(0xFFE0E0E0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Não tem conta? ',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navegação para a tela de registro
                            Navigator.pushNamed(context, '/register');
                          },
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212121),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputFormLocal extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;
  final int? maxLines;
  final IconData? icon;
  final bool obscureText;

  const InputFormLocal({
    required this.hintText,
    required this.label,
    this.controller,
    this.maxLines = 1,
    this.icon,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: icon != null
                ? Icon(icon, color: Colors.grey[500])
                : null,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
