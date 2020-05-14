import 'package:flutter/material.dart';
import '../../Widgets/SearchBarWidget.dart';
import '../../AppTheme.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //BuildContext _mainContext;

  var categories = [
    {'Id': 1, 'Label': 'By Ingredients', 'IsSelected': true},
    {'Id': 2, 'Label': 'By Course', 'IsSelected': false},
    {'Id': 3, 'Label': 'By Type', 'IsSelected': false}
  ];

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
            ],
          ),
        ),
      ),
    );
  }

  void toggleCategorySelection(int selectedId) {
    setState(() {
      for (var category in categories) {
        category['IsSelected'] = category['Id'] == selectedId;
      }
    });
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
