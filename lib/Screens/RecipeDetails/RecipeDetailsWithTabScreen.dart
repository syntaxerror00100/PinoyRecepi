import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import '../RecipeDetails/Ingredients.dart';
import '../RecipeDetails/Instructions.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeDetailsWithTabScreen extends StatelessWidget {
  static const String route = 'recipe-details-with-tabs';

  @override
  Widget build(BuildContext context) {
    final RecepiModel selectedRecepi =
        ModalRoute.of(context).settings.arguments;

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
            selectedRecepi.title,
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
                      tag: selectedRecepi.id,
                      child: CachedNetworkImage(
                        imageUrl: selectedRecepi.thumbNailUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 65,
                  child: getTabUI(selectedRecepi.id),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTabUI(int selectedRecipeId) {
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
              recepiId: selectedRecipeId,
            ),
            Instructions(
              recepiId: selectedRecipeId,
            ),
            // Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
