import 'package:flutter/material.dart';

class Category {
  final String name;
  final List<String> items;

  Category({required this.name, required this.items});
}

final List<Category> categories = [
  Category(name: 'Medicina', items: ['Vitaminas', 'Suplementos', 'Analgésicos']),
  Category(name: 'Ropa', items: ['Camisa', 'Pantalones', 'Abrigos']),
  Category(name: 'Comida', items: ['Manzana', 'Guineos', 'Zanahorias', 'Lata de atún', 'Lata de sardina']),
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
                // TODO: Botón eliminar
              },
            ),
          ],
        ),
      ),
    );
  }

  void goToCategoryItems(String category) {
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
    final selectedCategory = categories.firstWhere((c) => c.name == category);

    return Scaffold(
      appBar: AppBar(
        title: Text('Items en $category'),
      ),
      backgroundColor: Colors.teal,
      body: ListView.builder(
        itemCount: selectedCategory.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              selectedCategory.items[index],
              style: const TextStyle(color: Colors.white), 
            ),
          );
        },
      ),
    );
  }
}
