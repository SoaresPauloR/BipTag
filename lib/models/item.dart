import 'dart:typed_data';

class Item {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String category;
  final String status;
  final Uint8List? fiscalNote;
  final Uint8List? image;

  Item({
    this.id = 0,
    this.userId = 0,
    this.name = '',
    this.description = '',
    this.category = '',
    this.status = 'Created',
    this.fiscalNote,
    this.image,
  });

  // Métodos úteis para serialização (ex: se for usar SQLite local no Flutter com sqflite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'category': category,
      'status': status,
      'fiscal_note': fiscalNote,
      'image': image,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      status: map['status'] ?? 'Created',
      fiscalNote: map['fiscal_note'],
      image: map['image'],
    );
  }
}
