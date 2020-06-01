import 'package:flutter/material.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../../Models/RecepiModel.dart';
import '../../Widgets/RecipeList.dart';

class SearchResult extends StatelessWidget {
  final String searchQuery;

  SearchResult({this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return searchQuery.length < 3
        ? SizedBox()
        : FutureBuilder(
            future: DatabaseRepository.recipeRepository
                .searchRecipeBytitle(searchQuery),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var recepiListResult = (snapshot.data as List<RecepiModel>);
                if (recepiListResult.length == 0)
                  return Text('No result found..');

                return RecipeList(recipes: recepiListResult);
              }
              return Text('Searching...');
            });
  }
}
