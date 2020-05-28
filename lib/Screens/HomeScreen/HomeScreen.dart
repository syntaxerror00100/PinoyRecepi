import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinoy_recipes/ViewModel/CategoryItemViewModel.dart';
import '../../Widgets/SearchBarWidget.dart';
import '../../AppTheme.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../../Enums/Enums.dart';
import './../../ViewModel/CategoryViewModel.dart';
import '../RecipeList/RecipeListScreen.dart';
import '../../DTO/RecipeListScreenParamDto.dart';
import 'Category.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //BuildContext _mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              SearchBarWidget(),
              SizedBox(height: 5),
              Expanded(child: Category()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(
            Icons.home,
            color: Theme.of(context).backgroundColor,
          ),
          Icon(
            Icons.favorite,
            color: Theme.of(context).backgroundColor,
          ),
        ],
        color: Theme.of(context).primaryColor,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        height: 55,
        onTap: (index) {},
      ),
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
