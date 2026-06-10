import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/inventory_provider.dart';

class InventoryForm extends StatelessWidget {
  const InventoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Novo Item'),
        scrolledUnderElevation: 0,
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: FormInventory(),
        ),
      ),
    );
  }
}

class FormInventory extends StatefulWidget {
  const FormInventory({super.key});

  @override
  State<FormInventory> createState() => _FormInventoryState();
}

class _FormInventoryState extends State<FormInventory> {
  // Controladores para pegar o que o usuário digitar
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.grey[200],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey[500],
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Adicionar foto do item",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Passa os controladores para os campos
                  InputForm(
                    label: "Nome do Item",
                    hintText: "Digite o nome do item.",
                    controller: _nameController,
                    icon: Icons.inventory_2_outlined,
                  ),

                  InputForm(
                    label: "Descrição",
                    hintText: "Digite a descrição do item.",
                    controller: _descController,
                    maxLines: 3,
                  ),

                  InputForm(
                    label: "Categoria",
                    hintText: "Digite uma categoria do item.",
                    controller: _categoryController,
                    icon: Icons.category_outlined,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Cria um objeto Item com o que foi digitado
                final newItem = Item(
                  id: DateTime.now().millisecondsSinceEpoch,
                  userId: 101,
                  name: _nameController.text.isEmpty ? 'Item sem nome' : _nameController.text,
                  description: _descController.text,
                  category: _categoryController.text.isEmpty ? 'Geral' : _categoryController.text,
                  status: 'Created',
                );
                // Lê o Provider e adiciona o Item no Inventário
                context.read<InventoryProvider>().addItem(newItem);
                // Fecha o formulário e volta para o Inventário
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF282828),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Salvar Item',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InputForm extends StatelessWidget {
  final String hintText;
  final String label;
  final TextEditingController? controller;
  final int? maxLines;
  final IconData? icon;

  const InputForm({
    required this.hintText,
    required this.label,
    this.controller,
    this.maxLines = 1,
    this.icon,
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
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, color: Colors.grey[500]) : null,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            // Bordas dos inputs suavizadas para bater com o design system do seu app
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
              borderSide: const BorderSide(color: Color(0xFF212121), width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}