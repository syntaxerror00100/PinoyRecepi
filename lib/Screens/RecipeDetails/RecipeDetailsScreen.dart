import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import './Ingredients.dart';

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
            //title: Text("SliverAppBar Title"),
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                selectedRecepi.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
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
              ...getSampleList(),
            ]),
          )
        ],
      ),
    );
  }

  List<Widget> getSampleList() {
    final list = new List<int>.generate(50, (int index) => index * index);

    return list.map((e) => Text(e.toString())).toList();
  }
}
