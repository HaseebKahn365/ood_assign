import 'package:flutter/material.dart';

enum ItemStatus { AVAILABLE, BORROWED, LENT }

class item {
  String title;
  String? description;
  String? maker;

  double? length;
  double? width;
  double? height;

  ItemStatus status;

  Contact? owner;

  Image? itemImage;

  item({required this.title, this.maker, this.description, this.length, this.width, this.height, this.itemImage, this.owner, this.status = ItemStatus.AVAILABLE});
}

class Inventory {
  List<item> items = [];

  Inventory() {
    items.add(item(title: 'Lawn Mower', description: 'A lawn mower for cutting grass', maker: 'Honda', length: 1.5, width: 1.5, height: 1.5));
    items.add(item(title: 'Drill', description: 'A drill for making holes', maker: 'Bosch'));
    items.add(
      item(title: 'Screwdriver', description: 'A screwdriver for tightening screws', maker: 'Stanley', status: ItemStatus.BORROWED, owner: Contact(name: 'John Doe', email: 'johndoe@gmail.com')),
    );
    items.add(item(title: 'Hammer', description: 'A hammer for hitting nails', maker: 'Stanley'));

    contacts.add(Contact(name: 'John Doe', email: 'johndoe@gmail.com'));
    contacts.add(Contact(name: 'Abdul Haseeb', email: 'abdulhaseeb@gmail.com'));
    contacts.add(Contact(name: 'Ali', email: 'ali@yahoo.com'));
  }

  List<Contact> contacts = [];

  void addItem(item newItem) {
    if (items.any((element) => element.title == newItem.title)) {
      throw Exception('Item with same name already exists');
    }
  }

  void addContact(Contact newContact) {
    if (contacts.any((element) => element.email == newContact.email)) {
      throw Exception('Contact with same email already exists');
    } else if (contacts.any((element) => element.name == newContact.name)) {
      throw Exception('Contact with same name already exists');
    }
    contacts.add(newContact);
  }

  void removeItem(item itemToRemove) {
    items.remove(itemToRemove);
  }

  void updateItem(item itemToUpdate, item newItem) {
    items[items.indexOf(itemToUpdate)] = newItem;
  }

  void changeItemStatus(item itemToChange, ItemStatus newStatus) {
    items[items.indexOf(itemToChange)].status = newStatus;
  }

  List<item> getAvailableItems() {
    return items.where((element) => element.status == ItemStatus.AVAILABLE).toList();
  }

  List<item> getBorrowedItems() {
    return items.where((element) => element.status == ItemStatus.BORROWED).toList();
  }
}

class Contact {
  String name;
  String email;

  Contact({required this.name, required this.email});
}
