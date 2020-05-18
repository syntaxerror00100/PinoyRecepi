import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Screens/HomeScreen/HomeScreen.dart';
import 'package:pinoy_recipes/Screens/Recipe/RecipeListScreen.dart';

import './AppTheme.dart';
import './Screens/HomeScreen/HomeScreen.dart';
import './Screens/Recipe/RecipeListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTheme.appName,
      theme: AppTheme.lighTheme(context),
      // home: HomeScreen(),
      routes: {
        HomeScreen.route: (_) => HomeScreen(),
        RecipesListScreen.route: (_) => RecipesListScreen(),
      },
    );
  }
}
