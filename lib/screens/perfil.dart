import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),

              // Foto de Perfil (Avatar)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 40,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),

              // Nome e Email
              const Text(
                'Maria Silva',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'maria@email.com',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 40),

              // Seção: DADOS PESSOAIS
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'DADOS PESSOAIS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[500],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Card: Telefone
              _buildInfoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telefone',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '(11) 99999-9999',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Card: Notificações
              _buildInfoCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notificações',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _notificationsEnabled ? 'Ativadas' : 'Desativadas',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF212121),
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _notificationsEnabled,
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF212121),
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[300],
                      onChanged: (bool value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Card: Créditos do app
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/creditos');
                },
                borderRadius: BorderRadius.circular(12),
                child: _buildInfoCard(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Créditos do app',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF212121),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Botão Sair
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Text(
                  'Sair da Conta',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: child,
    );
  }
}
