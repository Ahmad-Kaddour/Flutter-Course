import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    _isLoading = true;
    final url = Uri.https(
      'flutter-prep-d8772-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final loadedItems = [
        for (final item in listData.entries)
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category:
                categories.entries
                    .firstWhere(
                      (category) =>
                          category.value.title == item.value['category'],
                    )
                    .value,
          ),
      ];

      setState(() {
        _isLoading = false;
        _groceryItems = loadedItems;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _error = 'Something went wrong! Please try again later';
      });
    }
  }

  void _addItem() async {
    final item = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const NewItem()));

    if (item == null) return;

    setState(() {
      _groceryItems.add(item);
    });
  }

  void _removeItem(GroceryItem item) async {
    final itemIndex = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https(
      'flutter-prep-d8772-default-rtdb.firebaseio.com',
      'shopping-list/${item.id}.json',
    );

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(itemIndex, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items add yet!'));

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder:
            (itemContext, index) => Dismissible(
              onDismissed: (direction) => _removeItem(_groceryItems[index]),
              key: ValueKey(_groceryItems[index].id),
              child: ListTile(
                leading: Container(
                  width: 24,
                  height: 24,
                  color: _groceryItems[index].category.color,
                ),
                title: Text(_groceryItems[index].name),
                trailing: Text(_groceryItems[index].quantity.toString()),
              ),
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
