import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const route = 'recepi-details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            //title: Text("SliverAppBar Title"),
            expandedHeight: 220.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              background: Image.network(
                'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
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
