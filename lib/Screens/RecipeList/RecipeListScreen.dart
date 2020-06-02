import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Enums/Enums.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import 'package:pinoy_recipes/Widgets/RecipeList.dart';
import '../../DTO/RecipeListScreenParamDto.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../../Widgets/LoadingIndicatorWidget.dart';
import '../../Widgets/RecipeListNew.dart';

class RecipesListScreen extends StatelessWidget {
  static const route = 'Recipe-list';

  String _selectedTitle;
  CategoryEnum _selectedCategoryType;

  var _isRecipesInitialized = false;
  List<RecepiModel> _recipes;

  @override
  Widget build(BuildContext context) {
    final RecipeListScreenParamDto navigationParam =
        ModalRoute.of(context).settings.arguments;
    _selectedTitle = navigationParam.title;
    _selectedCategoryType = navigationParam.category;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(context, _selectedTitle),
              getRecipeListUIFutureBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchAndLoadRecipes() async {
    _recipes = await DatabaseRepository.recipeRepository.getRecepiesByCategory(
      _selectedCategoryType,
      _selectedTitle,
    );
  }

  Widget getRecipeListUIFutureBuilder() {
    if (_isRecipesInitialized) return getRecipeListUI();

    return FutureBuilder(
        future: fetchAndLoadRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _isRecipesInitialized = true;
            return getRecipeListUI();
          } else {
            return LoadingIndicatorWidget();
          }
        });
  }

  Widget getRecipeListUI() {
    return Expanded(
      child: RecipeList(
        recipes: _recipes,
      ),

      //  ListView.builder(
      //   itemCount: _recipes.length,
      //   itemBuilder: (ctx, index) {
      //     final recipe = _recipes[index];
      //     return RecepiListItem(
      //       recepi: recipe,
      //     );
      //   },
      // ),
    );
  }

  Widget getAppBarUI(BuildContext ctx, String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 18,
        right: 18,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(ctx);
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 0.27,
                  color: Colors.black87, // DesignCourseAppTheme.darkerText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
