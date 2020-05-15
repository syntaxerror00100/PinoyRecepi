import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../Widgets/SearchBarWidget.dart';
import '../../AppTheme.dart';
import '../../DataAccess/RecepiMainIngredientsRepository.dart';
import '../../DataAccess/RecipeCourseRepository.dart';
import '../../DataAccess/RecipeTypeRepository.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //BuildContext _mainContext;

  @override
  void initState() {
    _loadCategories(1);

    super.initState();
  }

  var categories = [
    {'Id': 1, 'Label': 'By Ingredients', 'IsSelected': true},
    {'Id': 2, 'Label': 'By Course', 'IsSelected': false},
    {'Id': 3, 'Label': 'By Type', 'IsSelected': false}
  ];

  var categoryItems = [];

  void _loadCategories(int id) async {
    var categoryResults = [];
    switch (id) {
      case 1:
        final results = await RecepiMainIngredientsRepository().getAll();
        categoryResults = results
            .map((e) => {
                  'title': e.name,
                  'url':
                      'https://panlasangpinoy.com/wp-content/uploads/2015/05/Pininyahang-manok_-266x160.jpg'
                })
            .toList();
        print('Ingredients');
        break;
      case 2:
        final results = await RecipeCourseRepository().getAll();
        categoryResults = results
            .map((e) => {
                  'title': e.name,
                  'url':
                      'https://panlasangpinoy.com/wp-content/uploads/2015/05/Pininyahang-manok_-266x160.jpg'
                })
            .toList();
        print('Course');
        break;
      case 3:
        final results = await RecipeTypeRepository().getAll();
        categoryResults = results
            .map((e) => {
                  'title': e.name,
                  'url':
                      'https://panlasangpinoy.com/wp-content/uploads/2015/05/Pininyahang-manok_-266x160.jpg'
                })
            .toList();
        print('Type');
        break;
    }

    setState(() {
      categoryItems = categoryResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  _mainContext = context;
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
              .map((e) => getCategoryItem(e['title'], e['url']))
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
      child: Container(
        width: 180,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
          color: Colors.red,
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

  void toggleCategorySelection(int selectedId) async {
    setState(() {
      for (var category in categories) {
        category['IsSelected'] = category['Id'] == selectedId;
      }
    });
    await _loadCategories(selectedId);
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
          ...categories
              .map((e) =>
                  getCategoryButton(e['Label'], e['IsSelected'], e['Id']))
              .toList(),
          // getCategoryButton('By Ingredients', false),
          // getCategoryButton('By Course', false),
          // getCategoryButton('By Type', false),
        ],
      ),
    );
  }

  Widget getCategoryButton(String label, bool isActive, int id) {
    return InkWell(
      onTap: () {
        toggleCategorySelection(id);
      },
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
      child: Container(
          width: 120,
          height: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryColor : Colors.transparent,
            border: Border.all(
              color: AppTheme.primaryColor,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : AppTheme.primaryColor,
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
