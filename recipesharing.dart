import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Recipe {
  final String title;
  final String description;

  Recipe(this.title, this.description);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Sharing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RecipeApp(),
    );
  }
}

class RecipeApp extends StatefulWidget {
  @override
  _RecipeAppState createState() => _RecipeAppState();
}

class _RecipeAppState extends State<RecipeApp> {
  List<Recipe> recipes = [];

  void _addRecipe(String title, String description) {
    setState(() {
      recipes.add(Recipe(title, description));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Sharing'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipes[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddRecipeDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddRecipeDialog(BuildContext context) {
    String title = '';
    String description = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Recipe'),
          content: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(labelText: 'Recipe Title'),
              ),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(labelText: 'Recipe Description'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addRecipe(title, description);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  RecipeCard(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              recipe.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              recipe.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
