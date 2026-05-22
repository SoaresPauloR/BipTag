import 'package:flutter/material.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('Inventory Screen')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/inventory/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
