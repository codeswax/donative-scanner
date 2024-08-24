import 'package:flutter/material.dart';

class Category {
  final String name;
  final List<String> items;

  Category({required this.name, required this.items});
}

final List<Category> categories = [
  Category(name: 'Medicina', items: ['Laptop', 'Smartphone', 'Camera']),
  Category(name: 'Ropa', items: ['Shirt', 'Pants', 'Jacket']),
  Category(name: 'Comida', items: ['Apples', 'Bananas', 'Carrots', 'Lata de atún', 'Lata de sardina']),
];

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return categoryContainer(
            categories[index].name,
            categories[index].items.length,
          );
        },
      ),
    );
  }

  Widget categoryContainer(String category, int itemCount) {
    return GestureDetector(
      onTap: () {
        goToCategoryItems(category);
      },
      child: Container(
        width: 310,
        height: 110,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.teal[200],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.category,
              color: Colors.teal,
              size: 50.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categoría: $category',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Número de ítems: $itemCount',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            GestureDetector(
              child: const Icon(
                Icons.delete_forever,
                color: Colors.red,
                size: 25.0,
              ),
              onTap: () {
                // Lógica para eliminar la categoría
              },
            ),
          ],
        ),
      ),
    );
  }

  void goToCategoryItems(String category) {
    // Navegar a una nueva página que muestre los ítems de la categoría
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryItemsPage(category: category),
      ),
    );
  }
}

class CategoryItemsPage extends StatelessWidget {
  final String category;

  const CategoryItemsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Encuentra la categoría seleccionada
    final selectedCategory = categories.firstWhere((c) => c.name == category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Items en $category'),
      ),
      body: ListView.builder(
        itemCount: selectedCategory.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedCategory.items[index]),
          );
        },
      ),
    );
  }
}

