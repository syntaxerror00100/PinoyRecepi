import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Screens/HomeScreen/HomeScreen.dart';
import 'package:pinoy_recipes/Screens/RecipeList/RecipeListScreen.dart';
import './Screens/RecipeDetails/RecipeDetailsScreen.dart';

import './AppTheme.dart';
import './Screens/HomeScreen/HomeScreen.dart';
import './Screens/RecipeList/RecipeListScreen.dart';
import './Screens/RecipeDetails/RecipeDetailsScreen_new.dart';
import './Screens/RecipeDetails/RecipeDetailsWithTabScreen.dart';

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
        RecipeDetailsScreen.route: (_) => RecipeDetailsScreen(),
        RecipeDetailsScreen_new.route: (_) => RecipeDetailsScreen_new(),
        RecipeDetailsWithTabScreen.route: (_) => RecipeDetailsWithTabScreen(),
      },
    );
  }
}
