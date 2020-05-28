import 'package:flutter/material.dart';
import 'package:pinoy_recipes/DTO/RecipeListScreenParamDto.dart';
import 'package:pinoy_recipes/DataAccess/DatabaseRepository.dart';
import 'package:pinoy_recipes/Enums/Enums.dart';
import 'package:pinoy_recipes/Screens/RecipeList/RecipeListScreen.dart';
import 'package:pinoy_recipes/ViewModel/CategoryItemViewModel.dart';
import 'package:pinoy_recipes/ViewModel/CategoryViewModel.dart';

import '../../AppTheme.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    _loadCategories(CategoryEnum.ByMainIngredients);

    super.initState();
  }

  var categories = [
    CategoryViewModel(
      category: CategoryEnum.ByMainIngredients,
      label: 'By Ingredients',
      isSelected: true,
    ),
    CategoryViewModel(
      category: CategoryEnum.ByCourse,
      label: 'By Course',
    ),
    CategoryViewModel(
      category: CategoryEnum.ByType,
      label: 'By Type',
    ),
  ];

  List<CategoryItemViewModel> categoryItems = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        getCategoriesUI(context),
        SizedBox(height: 15),
        Expanded(
          child: getCategoryList(),
        ),
      ],
    );
  }

  void _loadCategories(CategoryEnum selectedCategory) async {
    var categoryResults = [];
    switch (selectedCategory) {
      case CategoryEnum.ByMainIngredients:
        final results =
            await DatabaseRepository.recipeMainIngredientsRepository.getAll();
        categoryResults = results
            .map((e) => new CategoryItemViewModel(
                  e.name,
                  e.thumbNaimImageUrl,
                ))
            .toList();
        break;
      case CategoryEnum.ByCourse:
        final results =
            await DatabaseRepository.recipeCourseRepository.getAll();
        categoryResults = results
            .map((e) => new CategoryItemViewModel(
                  e.name,
                  e.thumbNaimImageUrl,
                ))
            .toList();
        break;
      case CategoryEnum.ByType:
        final results = await DatabaseRepository.recipeTypeRepository.getAll();
        categoryResults = results
            .map((e) => new CategoryItemViewModel(
                  e.name,
                  e.thumbNaimImageUrl,
                ))
            .toList();
        break;
    }

    setState(
      () {
        categoryItems = categoryResults;
      },
    );
  }

  Widget getCategoryList() {
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView(
        children: [
          ...categoryItems
              .map((e) => getCategoryItem_new(e.title, e.imageUri))
              .toList()
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
      ),
    );
  }

  Widget getCategoryItem(String title, String url) {
    return InkWell(
      onTap: () {
        final selectedCategory =
            categories.singleWhere((element) => element.isSelected);
        final selectedCategoryItemTitle = title;

        Navigator.pushNamed(context, RecipesListScreen.route,
            arguments: new RecipeListScreenParamDto(
                selectedCategoryItemTitle, selectedCategory.category));
      },
      child: Container(
        width: 180,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          color: Colors.teal,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 4, right: 4),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  width: 150,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withOpacity(.65),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      )),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryItem_new(String title, String url) {
    return InkWell(
      onTap: () {
        final selectedCategory =
            categories.singleWhere((element) => element.isSelected);
        final selectedCategoryItemTitle = title;

        Navigator.pushNamed(
          context,
          RecipesListScreen.route,
          arguments: new RecipeListScreenParamDto(
            selectedCategoryItemTitle,
            selectedCategory.category,
          ),
        );
      },
      child: Container(
        height: 200,
        child: Stack(
          children: <Widget>[
            Container(
              width: 180,
              height: 113,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                image: DecorationImage(
                  image: NetworkImage(url),
                  fit: BoxFit.cover,
                ),
                color: Colors.teal,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              padding: EdgeInsets.only(
                left: 4,
                right: 4,
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  width: 150,
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    //color: AppTheme.lighGray.withOpacity(.65),
                    color: Theme.of(context).accentColor.withOpacity(.65),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white,
                          ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void toggleCategorySelection(CategoryViewModel selectedCategory) async {
    setState(
      () {
        for (var category in categories) {
          category.isSelected = category.category == selectedCategory.category;
        }
      },
    );
    debugPrint('====HERE===');
    await _loadCategories(selectedCategory.category);
  }

  Widget getCategoriesUI(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ...categories.map((e) => getCategoryButton(e)).toList(),
          // getCategoryButton('By Ingredients', false),
          // getCategoryButton('By Course', false),
          // getCategoryButton('By Type', false),
        ],
      ),
    );
  }

  Widget getCategoryButton(CategoryViewModel selectedCategory) {
    return InkWell(
      onTap: () {
        debugPrint('=== CATEGORY SELECT TRIGGERED ==');
        toggleCategorySelection(selectedCategory);
      },
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      child: Container(
          width: 120,
          height: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: selectedCategory.isSelected
                ? AppTheme.primaryColor
                : Colors.transparent,
            border: Border.all(
              color: AppTheme.primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              selectedCategory.label,
              style: TextStyle(
                color: selectedCategory.isSelected
                    ? Colors.white
                    : AppTheme.primaryColor,
              ),
            ),
          )),
    );
  }
}
