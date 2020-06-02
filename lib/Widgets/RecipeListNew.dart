import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import 'package:pinoy_recipes/Screens/RecipeList/RecipeListItem.dart';

class RecipeListNew extends StatefulWidget {
  final List<RecepiModel> recipes;

  const RecipeListNew({this.recipes});

  @override
  _RecipeListNewState createState() => _RecipeListNewState();
}

class _RecipeListNewState extends State<RecipeListNew> {
  final scrollController = ScrollController();
  double topContainer = 0;

  @override
  void initState() {
    // TODO: implement initState

    scrollController.addListener(() {
      setState(() {
        topContainer = scrollController.offset / 189;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      itemCount: widget.recipes.length,
      itemBuilder: (ctx, index) {
        final recipe = widget.recipes[index];

        double scale = 1.0;
        if (topContainer > 0.5) {
          scale = index + 0.5 - topContainer;
          if (scale < 0) {
            scale = 0;
          } else if (scale > 1) {
            scale = 1;
          }
        }

        debugPrint(scale.toString());
        return Opacity(
          opacity: scale,
          child: Transform(
            transform: Matrix4.identity()..scale(scale, scale),
            alignment: Alignment.bottomCenter,
            child: Align(
              heightFactor: .7,
              alignment: Alignment.topCenter,
              child: RecepiListItem(
                recepi: recipe,
              ),
            ),
          ),
        );
      },
    );
  }
}
