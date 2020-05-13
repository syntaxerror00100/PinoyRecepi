import 'package:flutter/material.dart';
import '../../Widgets/SearchBarWidget.dart';

class HomeScreen extends StatelessWidget {
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
              getCategoriesUI(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCategoriesUI() {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('By main ingredient'),
          Text('By Course'),
          Text('By Type'),
        ],
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
