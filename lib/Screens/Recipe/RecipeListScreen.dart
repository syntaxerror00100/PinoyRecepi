import 'package:flutter/material.dart';

class RecipesListScreen extends StatelessWidget {
  static const route = 'Recipe-list';
  final String categoryId;

  const RecipesListScreen({Key key, this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Object> navigationParam =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(context),
              Text(navigationParam['title']),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI(BuildContext ctx) {
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
