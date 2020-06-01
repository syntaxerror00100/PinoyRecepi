import 'package:flutter/material.dart';
import 'package:pinoy_recipes/DataAccess/DatabaseRepository.dart';

class FavoriteIcon extends StatefulWidget {
  final int recipeId;

  const FavoriteIcon({Key key, this.recipeId}) : super(key: key);

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool _isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(
      Duration.zero,
      () {
        DatabaseRepository.favoriteRepository
            .isRecipeFavorite(widget.recipeId)
            .then(
          (value) {
            setState(
              () {
                _isFavorite = value;
              },
            );
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        DatabaseRepository.favoriteRepository
            .setAsFavorite(!_isFavorite, widget.recipeId);

        setState(
          () {
            _isFavorite = !_isFavorite;
          },
        );
      },
      backgroundColor: Colors.white,
      child: Icon(
        _isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 35,
        color: Theme.of(context).accentColor,
      ),
    );
    ;
  }
}
