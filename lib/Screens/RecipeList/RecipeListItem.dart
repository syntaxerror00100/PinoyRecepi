import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import '../RecipeDetails/RecipeDetailsScreen.dart';

class RecepiListItem extends StatelessWidget {
  final RecepiModel recepi;

  const RecepiListItem({Key key, this.recepi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RecipeDetailsScreen.route);
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _getImageRecepiImage(),
                Positioned(
                  bottom: 10,
                  right: 0,
                  width: 300,
                  child: _getTitle(context),
                )
              ],
            ),
            _getBottomItems(),
          ],
        ),
      ),
    );
  }

  Widget _getTitle(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        recepi.title,
        style: Theme.of(ctx).textTheme.headline6,
        overflow: TextOverflow.fade,
      ),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
    );
  }

  Widget _getImageRecepiImage() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: CachedNetworkImage(
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        imageUrl: recepi.thumbNailUrl,
        //placeholder: (_, __) => CircularProgressIndicator(),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(
          value: downloadProgress.progress,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget _getBottomItems() {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                recepi.summary,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            Icon(
              Icons.favorite_border,
            )
          ],
        ),
      ),
      height: 50,
    );
  }
}
