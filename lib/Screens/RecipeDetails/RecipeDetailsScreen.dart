import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import './Ingredients.dart';
import './Instructions.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const route = 'recepi-details';

  @override
  Widget build(BuildContext context) {
    final RecepiModel selectedRecepi =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            brightness: Brightness.dark,
            backgroundColor: Theme.of(context).backgroundColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Icon(Icons.favorite)),
            ],
            //title: Text("SliverAppBar Title"),
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  selectedRecepi.title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.0,
                  ),
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: selectedRecepi.thumbNailUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Ingredients(
                recepiId: selectedRecepi.id,
              ),
              Instructions(
                recepiId: selectedRecepi.id,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
