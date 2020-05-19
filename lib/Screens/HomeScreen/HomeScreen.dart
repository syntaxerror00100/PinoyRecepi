import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinoy_recipes/ViewModel/CategoryItemViewModel.dart';
import '../../Widgets/SearchBarWidget.dart';
import '../../AppTheme.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../../Enums/Enums.dart';
import './../../ViewModel/CategoryViewModel.dart';
import '../Recipe/RecipeListScreen.dart';
import '../../DTO/RecipeListScreenParamDto.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //BuildContext _mainContext;

  @override
  void initState() {
    _loadCategories(CategoryEnum.ByMainIngredients);

    super.initState();
  }

  BuildContext _mainContext;

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

    setState(() {
      categoryItems = categoryResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    _mainContext = context;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              SearchBarWidget(),
              SizedBox(height: 5),
              getCategoriesUI(context),
              SizedBox(height: 15),
              Expanded(
                child: getCategoryList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCategoryList() {
    return Container(
      margin: EdgeInsets.all(10),
      child: GridView(
        children: [
          ...categoryItems
              .map((e) => getCategoryItem(e.title, e.imageUri))
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

        Navigator.pushNamed(_mainContext, RecipesListScreen.route,
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

  void toggleCategorySelection(CategoryViewModel selectedCategory) async {
    setState(() {
      for (var category in categories) {
        category.isSelected = category.category == selectedCategory.category;
      }
    });
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

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 18,
        right: 18,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Pinoy recipes',
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
