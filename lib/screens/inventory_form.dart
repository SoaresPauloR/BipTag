import 'package:flutter/material.dart';

class InventoryForm extends StatelessWidget {
  const InventoryForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Item'),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormInventory(),
      ),
    );
  }
}

class FormInventory extends StatelessWidget {
  const FormInventory({
    super.key,
  });

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
                    color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(64.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey[500],
                          ),
                          Text("Adicionar foto do item"),
                        ],
                      ),
                    ),
                  ),

                  InputForm(
                    label: "Nome do Item",
                    hintText: "Digite o nome do item.",
                    controller: null,
                    icon: Icons.inventory_2_outlined,
                  ),

                  InputForm(
                    label: "Descrição",
                    hintText: "Digite a descrição do item.",
                    controller: null,
                    maxLines: 3,
                    // icon: Icons.description_outlined,
                  ),

                  InputForm(
                    label: "Categoria",
                    hintText: "Digite uma categoria do item.",
                    controller: null,
                    icon: Icons.category_outlined,
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Salvar Item'),
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
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        TextFormField(
          maxLines: maxLines,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon) : null,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            border: const OutlineInputBorder(),
          ),
          controller: controller,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
