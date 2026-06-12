import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../providers/inventory_provider.dart';
import '../services/orc_service.dart';

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
  // Variável que dispara a validação do formulário
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _categoryController = TextEditingController();

  bool _isProcessingImage = false;

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
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    onTap: _isProcessingImage
                        ? null
                        : () async {
                            setState(() {
                              _isProcessingImage = true;
                            });

                            final extractedData =
                                await OcrService.scanReceipt();

                            if (extractedData != null) {
                              _nameController.text =
                                  extractedData['name'] ?? '';
                              _descController.text =
                                  extractedData['description'] ?? '';
                              _categoryController.text =
                                  extractedData['category'] ?? '';
                            }
                            setState(() {
                              _isProcessingImage = false;
                            });
                          },
                    borderRadius: BorderRadius.circular(12),
                    child: Card(
                      color: Colors.grey[200],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: Column(
                          children: [
                            _isProcessingImage
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.grey[500],
                                    size: 32,
                                  ),
                            const SizedBox(height: 8),
                            Text(
                              _isProcessingImage
                                  ? "Lendo Nota Fiscal com IA..."
                                  : "Escanear Nota Fiscal",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Adicionei o validator em cada campo
                  InputForm(
                    label: "Nome do Item",
                    hintText: "Digite o nome do item.",
                    controller: _nameController,
                    icon: Icons.inventory_2_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'O nome do item é obrigatório';
                      }
                      return null;
                    },
                  ),

                  InputForm(
                    label: "Descrição",
                    hintText: "Digite a descrição do item.",
                    controller: _descController,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'A descrição não pode ficar vazia';
                      }
                      return null;
                    },
                  ),

                  InputForm(
                    label: "Categoria",
                    hintText: "Digite uma categoria do item.",
                    controller: _categoryController,
                    icon: Icons.category_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Informe uma categoria válida';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Só irá salvar se todos os campos estiverem preenchidos
                if (_formKey.currentState!.validate()) {
                  final newItem = Item(
                    id: DateTime.now().millisecondsSinceEpoch,
                    userId: 101,
                    name: _nameController.text,
                    description: _descController.text,
                    category: _categoryController.text,
                    status: 'Created',
                  );

                  context.read<InventoryProvider>().addItem(newItem);
                  Navigator.pop(context);
                }
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

  // Funçao de validaçao no componente
  final String? Function(String?)? validator;

  const InputForm({
    required this.hintText,
    required this.label,
    this.controller,
    this.maxLines = 1,
    this.icon,
    this.validator,
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
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            // Adicionei a borda de erro para ficar vermelho quando vazio
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
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
