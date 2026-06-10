import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _receiveNotifications = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF212121)),
          onPressed: () {
            Navigator.pop(context); // Volta para a tela anterior
          },
        ),
        title: const Text(
          'Criar conta',
          style: TextStyle(
            color: Color(0xFF212121),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Divider(color: Color(0xFFE0E0E0), height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputFormRegistration(
                      label: "Nome completo",
                      hintText: "Ex.: Maria Silva",
                      controller: _nameController,
                      icon: Icons.person_outline,
                    ),

                    InputFormRegistration(
                      label: "Email",
                      hintText: "seu@email.com",
                      controller: _emailController,
                      icon: Icons.email_outlined,
                    ),

                    InputFormRegistration(
                      label: "Telefone",
                      hintText: "(11) 99999-9999",
                      controller: _phoneController,
                      icon: Icons.phone_outlined,
                    ),

                    InputFormRegistration(
                      label: "Senha",
                      hintText: "••••••••",
                      controller: _passwordController,
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    InputFormRegistration(
                      label: "Confirmar senha",
                      hintText: "••••••••",
                      controller: _confirmPasswordController,
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    const SizedBox(height: 8),

                    // Switch de Notificações
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Receber notificações',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        Switch(
                          value: _receiveNotifications,
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF212121),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey[300],
                          onChanged: (bool value) {
                            setState(() {
                              _receiveNotifications = value;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Rodapé fixo com Botões
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Ação de criar a conta
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
                      'Criar conta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Já tem conta? Entrar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF424242),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Componente isolado para evitar conflito com o Login
class InputFormRegistration extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;
  final IconData? icon;
  final bool obscureText;

  const InputFormRegistration({
    required this.hintText,
    required this.label,
    this.controller,
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
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xFF212121),
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
