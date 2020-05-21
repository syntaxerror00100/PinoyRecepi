import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../Models/RecepiModel.dart';
import './Ingredients.dart';
import './Instructions.dart';

class RecipeDetailsScreen_new extends StatefulWidget {
  static const String route = 'recipe-details-screen-new';

  @override
  _RecipeDetailsScreen_newState createState() =>
      _RecipeDetailsScreen_newState();
}

class _RecipeDetailsScreen_newState extends State<RecipeDetailsScreen_new> {
  final _sliverAppBarMaxSpandHeight = 220.0;
  double _toolbarPlusStatusBarHeight;

  @override
  Widget build(BuildContext context) {
    _toolbarPlusStatusBarHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;

    final RecepiModel selectedRecepi =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
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
                expandedHeight: _sliverAppBarMaxSpandHeight,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(builder: (ctx, constraints) {
                  return FlexibleSpaceBar(
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
                  );
                }),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(
                          icon: Icon(Icons.shopping_basket),
                          text: "Ingredients"),
                      Tab(icon: Icon(Icons.room_service), text: "Insctruction"),
                    ],
                    onTap: (index) {},
                  ),
                ),
                pinned: true,
                // floating: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              Ingredients(
                recepiId: selectedRecepi.id,
              ),
              Instructions(
                recepiId: selectedRecepi.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
