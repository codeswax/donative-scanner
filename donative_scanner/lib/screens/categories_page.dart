import 'package:flutter/material.dart';
import 'package:donative_scanner/services/category_service.dart';
import 'package:donative_scanner/models/category.dart';
import 'package:donative_scanner/utils/color_constants.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    List<Category> categories = await CategoryService.getCategories();
    setState(() {
      _categories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25.0, right: 25.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return categoryContainer(_categories[index]);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
            alignment: Alignment.bottomCenter,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.teal[200],
                padding: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onPressed: () async {
                showCreateCategoryDialog();
              },
              child: Text("Crear categoría",
                  style: Theme.of(context).textTheme.labelLarge),
            ),
          ),
        ],
      ),
    );
  }

  Widget categoryContainer(Category category) {
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
                  'Categoría: ${category.name}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Número de ítems: ${category.guideProducts.length}',
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
                showDeletionDialog(category);
              },
            ),
          ],
        ),
      ),
    );
  }

  void goToCategoryItems(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryItemsPage(category: category),
      ),
    );
  }

  void showCreateCategoryDialog() {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final guideProductsController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Crear Nueva Categoría'),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8, // Ajusta el tamaño del diálogo al 80% del ancho de la pantalla
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextField(
                controller: guideProductsController,
                decoration: const InputDecoration(
                  labelText: 'Productos Guía (separados por coma y espacio)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(backgroundColor: teal),
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty &&
                  guideProductsController.text.isNotEmpty) {
                createCategory(
                  nameController.text,
                  descriptionController.text,
                  guideProductsController.text
                      .split(', ')
                      .map((e) => e.trim())
                      .toList(),
                );
                Navigator.of(context).pop();
              } else {
                showEmptyFieldsDialog();
              }
            },
            child: const Text('Crear', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            style: TextButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}


  void showEmptyFieldsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Por favor, completa todos los campos.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: teal),
              child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void createCategory(
      String name, String description, List<String> guideProducts) async {
    Category newCategory = Category(
      (_categories.isNotEmpty ? int.parse(_categories.last.id) + 1 : 1).toString(),
      name,
      description,
      guideProducts,
    );

    await CategoryService.postCategory(newCategory.id, newCategory.name,
        newCategory.description, newCategory.guideProducts);
    
    _loadCategories();

    showCategoryCreatedDialog(newCategory.name);
  }

  void showCategoryCreatedDialog(String categoryName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Categoría Creada'),
          content: Text('Categoría "$categoryName" creada satisfactoriamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: teal),
              child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void showDeletionDialog(Category category) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atención'),
          content: Text(
              'La categoría ${category.name} será eliminada. Esto no se puede deshacer.'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: teal),
              onPressed: () async {
                await CategoryService.deleteCategory(category.id);
                Navigator.of(context).pop(); // Cerrar el diálogo de confirmación de eliminación
                _loadCategories(); // Recargar la lista de categorías
                showCategoryDeletedDialog(category.name);
              },
              child:
                  const Text('Aceptar', style: TextStyle(color: Colors.white)),
            ),
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text('Cancelar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void showCategoryDeletedDialog(String categoryName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Categoría Eliminada'),
          content: Text('Categoría "$categoryName" eliminada satisfactoriamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(backgroundColor: teal),
              child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

class CategoryItemsPage extends StatelessWidget {
  final Category category;

  const CategoryItemsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Guía de donativos en ${category.name}')),
        backgroundColor: lightTeal,
      ),
      backgroundColor: Colors.teal,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              category.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: category.guideProducts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    category.guideProducts[index],
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
