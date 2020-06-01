import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import '../RecipeDetails/Ingredients.dart';
import '../RecipeDetails/Instructions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../RecipeDetails/FavoriteIcon.dart';

class RecipeDetailsWithTabScreen extends StatelessWidget {
  static const String route = 'recipe-details-with-tabs';
  BuildContext _mainContext;
  RecepiModel _selectedRecepi;
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    _mainContext = context;
    _selectedRecepi = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text(
            _selectedRecepi.title,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 0.27,
              color: Colors.black87, // DesignCourseAppTheme.darkerText,
            ),
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
        ),
        body: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 35,
                  child: Container(
                    width: double.infinity,
                    child: Hero(
                      tag: _selectedRecepi.id,
                      child: CachedNetworkImage(
                        imageUrl: _selectedRecepi.thumbNailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 65,
                  child: getTabUI(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTabUI() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(tabs: [
          Tab(
            text: 'Ingredients',
            icon: Icon(Icons.assignment_turned_in),
          ),
          Tab(
            text: 'Instruction',
            icon: FaIcon(
              FontAwesomeIcons.conciergeBell,
            ),
          ),
          // Tab(
          //   icon: Icon(Icons.info),
          // ),
        ]),
        body: TabBarView(
          children: [
            Ingredients(
              recepiId: _selectedRecepi.id,
            ),
            Instructions(
              recepiId: _selectedRecepi.id,
            ),
            // Icon(Icons.directions_bike),
          ],
        ),
        floatingActionButton: FavoriteIcon(
          recipeId: _selectedRecepi.id,
        ),
      ),
    );
  }
}
