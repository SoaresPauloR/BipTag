import 'package:biptag/models/item.dart';
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
      body: InventoryList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/inventory/create');
        },
        child: const Icon(Icons.add),
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
  final List<Item> inventory = [
    Item(
      id: 1,
      userId: 101,
      name: 'MacBook Pro M2',
      description: 'Notebook de uso pessoal/trabalho',
      category: 'Eletrônicos',
      status: 'Verified',
      // fiscalNote e image ficam como null por padrão, igual ao Kotlin
    ),
    Item(
      id: 2,
      userId: 101,
      name: 'Cadeira Herman Miller',
      description: 'Cadeira ergonômica do escritório',
      category: 'Móveis',
      status: 'Created',
    ),
    Item(
      id: 3,
      userId: 102,
      name: 'Monitor Dell 27"',
      description: 'Monitor secundário 4K',
      category: 'Eletrônicos',
      status: 'Stolen',
    ),
    Item(
      id: 4,
      userId: 105,
      name: 'Mochila North Face',
      description: 'Mochila de viagem preta',
      category: 'Acessórios',
      status: 'Created',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar item...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: inventory.length,
            itemBuilder: (context, index) {
              final item = inventory[index];
              return ItemCard(item);
            },
          ),
        ),
      ],
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
