import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import 'package:pinoy_recipes/Models/RecipeTagsModel.dart';
import '../RecipeDetails/RecipeDetailsScreen.dart';
import '../RecipeDetails/RecipeDetailsScreen_new.dart';
import '../RecipeDetails/RecipeDetailsWithTabScreen.dart';
import '../../DataAccess/DatabaseRepository.dart';

class RecepiListItem extends StatelessWidget {
  final RecepiModel recepi;
  String cookingTime = '';

  RecepiListItem({this.recepi});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RecipeDetailsWithTabScreen.route,
          arguments: recepi,
        );
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
                  top: 5,
                  right: 8,
                  child: _buildCookingTime(),
                  // child: Icon(
                  //   Icons.favorite_border,
                  //   size: 40,
                  //   color: Theme.of(context).accentColor,
                  // ),
                ),
                // Positioned(
                //   bottom: 10,
                //   right: 0,
                //   width: 300,
                //   child: _getTitle(context),
                // )
              ],
            ),
            _getBottomItems(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCookingTime() {
    return FutureBuilder(
        future: _getRecipeCookingTimeAsync(),
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.data.toString().isEmpty) return SizedBox();

              return _getCoockingTimeWidget(snapshot.data.toString());
              break;

            default:
              return Text('');
          }
        });
  }

  Widget _getCoockingTimeWidget(String cookingTimeLabel) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.timer,
          size: 30,
          color: Colors.white,
        ),
        Text(
          cookingTimeLabel,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }

  Future<String> _getRecipeCookingTimeAsync() async {
    var result = await DatabaseRepository.recipeTagRepository
        .getCookTimeByRecipeId(recepi.id);

    if (result == null) return '';

    return result.value;
  }

  Widget _getTitle(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Text(
            recepi.title,
            style: Theme.of(ctx).textTheme.headline6,
            overflow: TextOverflow.fade,
          ),
        ],
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
      child: Hero(
        tag: recepi.id,
        child: CachedNetworkImage(
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          imageUrl: recepi.thumbNailUrl,
          placeholder: (_, __) => Lottie.asset(
            'assets/image-loading.json',
            height: 200,
            fit: BoxFit.fill,
          ),
          // progressIndicatorBuilder: (context, url, downloadProgress) =>
          //     CircularProgressIndicator(
          //   value: downloadProgress.progress,
          // ),
          // errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _getBottomItems(BuildContext ctx) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  recepi.title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(ctx).textTheme.headline6.copyWith(
                        color: Colors.black87,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      height: 50,
    );
  }
}
