import 'package:flutter/material.dart';
import 'item_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: MaterialApp(
        title: 'Flutter CRUD with Provider',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ItemScreen(),
      ),
    );
  }
}

class ItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CRUD with Provider')),
      body: Consumer<ItemProvider>(
        builder: (context, itemProvider, child) {
          // Display the list of items using a ListView
          return ListView.builder(
            itemCount: itemProvider.items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(itemProvider.items[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Delete an item when the delete button is pressed
                    itemProvider.deleteItem(index);
                  },
                ),
                onTap: () {
                  // Update item when tapped
                  _showUpdateDialog(context, itemProvider, index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show dialog to add a new item
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Show a dialog to add a new item
  void _showAddDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter item name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Add the item if not empty
                if (controller.text.isNotEmpty) {
                  Provider.of<ItemProvider>(context, listen: false)
                      .addItem(controller.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show a dialog to update an existing item
  void _showUpdateDialog(
      BuildContext context, ItemProvider provider, int index) {
    final TextEditingController controller =
        TextEditingController(text: provider.items[index]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Item'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Update item name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Update the item if not empty
                if (controller.text.isNotEmpty) {
                  provider.updateItem(index, controller.text);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Update'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
