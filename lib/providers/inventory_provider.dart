import 'package:flutter/material.dart';
import 'package:biptag/models/item.dart';

class InventoryProvider extends ChangeNotifier {
  // Lista que está presente na tela
  final List<Item> _inventory = [
    Item(
      id: 1,
      userId: 101,
      name: 'MacBook Pro M2',
      description: 'Notebook de uso pessoal/trabalho',
      category: 'Eletrônicos',
      status: 'Verified',
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

  // Puxa a lista de forma segura (apenas leitura)
  List<Item> get inventory => List.unmodifiable(_inventory);

  // Adiciona Novo ITEM
  void addItem(Item item) {
    _inventory.add(item);
    notifyListeners();
  }

  // Remove o item da lista e avisa a tela para se atualizar
  void removeItem(Item item) {
    _inventory.remove(item);
    notifyListeners();
  }
}
