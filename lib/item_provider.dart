import 'package:flutter/material.dart';

class ItemProvider extends ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  // Create - Add a new item
  void addItem(String item) {
    _items.add(item);
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Read - Get all items
  List<String> getAllItems() {
    return _items;
  }

  // Update - Edit an existing item
  void updateItem(int index, String newItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = newItem;
      notifyListeners(); // Notify listeners after update
    }
  }

  // Delete - Remove an item
  void deleteItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners(); // Notify listeners after deletion
    }
  }
}
