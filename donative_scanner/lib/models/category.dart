class Category {
  final String categoryName;

  Category({
    required this.categoryName,
  });

  // Método para convertir de JSON a un objeto Category
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryName: json['category'],
    );
  }
}
