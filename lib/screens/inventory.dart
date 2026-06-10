import 'package:biptag/models/item.dart';
import 'package:flutter/material.dart';
import 'package:biptag/screens/perfil.dart';
import 'package:biptag/screens/map_screen.dart';
import 'package:provider/provider.dart';

import '../providers/inventory_provider.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const InventoryList(),
    const MapScreen(),
    const Perfil(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Inventory'
              : _selectedIndex == 1
              ? 'Mapa de Ativos'
              : 'Perfil',
        ),
        automaticallyImplyLeading: false,
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inventory/create');
              },
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onItemTapped: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<StatefulWidget> createState() {
    return InventoryListState();
  }
}

class InventoryListState extends State<InventoryList> {
  @override
  Widget build(BuildContext context) {
    // Escuta o Provider para manter a lista atualizada
    final inventoryState = context.watch<InventoryProvider>();
    final items = inventoryState.inventory;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Barra de Pesquisa
          TextField(
            decoration: InputDecoration(
              hintText: 'Buscar item...',
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              // Centraliza o texto
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12), // Borda arredondada
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Lista de Itens
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 0, bottom: 80),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ItemCard(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Card(
              child: SizedBox(
                width: 48,
                height: 48,
                child: Icon(Icons.no_photography_outlined),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(item.category),
                    ],
                  ),
                  StatusCard(status: item.status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.status,
  });

  final String status;

  Color? get _color =>
      {
        'Verified': Colors.black,
        'Stolen': Colors.red,
      }[status] ??
      Colors.grey[300];

  Color get _textColor =>
      {
        'Verified': Colors.white,
        'Stolen': Colors.white,
      }[status] ??
      Colors.black;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Text(
          status,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: _textColor,
          ),
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      child: BottomNavigationBar(
        elevation: 0,
        currentIndex: currentIndex,
        onTap: onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2),
            label: 'Inventário',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
