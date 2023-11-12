import 'package:flutter/material.dart';
import 'package:setupin/screens/shoplist_form.dart';

class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}

class ShopDesc{
  final String name;
  final int amount;
  final String description;
  static List<ShopDesc> savedItems = [];

  ShopDesc({required this.name, required this.amount, required this.description});
  void saveItem() {
    savedItems.add(this);
  }
  
}