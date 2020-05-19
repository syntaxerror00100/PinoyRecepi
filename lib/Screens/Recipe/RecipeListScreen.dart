import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Enums/Enums.dart';
import '../../DTO/RecipeListScreenParamDto.dart';
import '../../DataAccess/DatabaseRepository.dart';

class RecipesListScreen extends StatelessWidget {
  static const route = 'Recipe-list';
  final String categoryId;

  const RecipesListScreen({Key key, this.categoryId}) : super(key: key);

  Future<Widget> getRecipes(CategoryEnum category, String title) async {
    var recipes = await DatabaseRepository.recipeRepository
        .getRecepiesByCategory(category, title);
    return Column(
      children: <Widget>[
        ...recipes.map((e) => Text(e.title)).toList(),
      ],
    );
    //return recipes.map((e) => Text(e.title)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final RecipeListScreenParamDto navigationParam =
        ModalRoute.of(context).settings.arguments;
    final selectedTitle = navigationParam.title;
    final selectedCategoryType = navigationParam.category;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(context, selectedTitle),
              Text(selectedTitle),
              Container(
                child: FutureBuilder(
                    future: getRecipes(selectedCategoryType, selectedTitle),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print('====REAAADY NAAAA!!=====');
                        return snapshot.data;
                      } else
                        return Text('Loading...');
                    }),
              ),
            ],
          ),
        ),
      ),
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
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 0.27,
                color: Colors.black45, // DesignCourseAppTheme.darkerText,
              ),
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: null, // Image.asset('assets/design_course/userImage.png'),
          )
        ],
      ),
    );
  }
}
