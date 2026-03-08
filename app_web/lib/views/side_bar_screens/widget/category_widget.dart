import 'package:app_web/controller/category_controller.dart';
import 'package:app_web/models/category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => CategoryWidgetState();
}

class CategoryWidgetState extends State<CategoryWidget> {
  //a future that will hold the list of categories once loaded from the api
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  // Public method to reload categories
  void refresh() {
    setState(() {
      futureCategories = CategoryController().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No Categories"));
        } else {
          final categories = snapshot.data!;
          return Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((category) {
              return Image.network(category.image, height: 100, width: 100);
            }).toList(),
          );
        }
      },
    );
  }
}
