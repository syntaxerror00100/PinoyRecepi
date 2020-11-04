import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../AppTheme.dart';
import '../../Widgets/SearchBarWidget.dart';
import 'Category.dart';
import 'Favorites.dart';
import 'SearchResult.dart';

class HomeScreen_new extends StatefulWidget {
  static const route = '/';

  @override
  _HomeScreen_newState createState() => _HomeScreen_newState();
}

class _HomeScreen_newState extends State<HomeScreen_new> {
  final _pageController = PageController();
  int _pageIndex = 0;

  bool _isSearching = false;
  String _searchQuery = '';

  var pages = List<Widget>();

  @override
  Widget build(BuildContext context) {
    pages.add(_buildMainPage());
    pages.add(Center(child: Text('favs')));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          'Pinoy recipes',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.27,
            color: AppTheme.textColor, // DesignCourseAppTheme.darkerText,
          ),
        ),
      ),
      body: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: TabBar(tabs: [
              Text('By Ingredients'),
              Text('By Course'),
              Text('By Type'),
            ]),
            body: TabBarView(children: []),
          )),
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        items: [
          Icon(
            Icons.home,
            color: Theme.of(context).backgroundColor,
          ),
          Icon(
            Icons.favorite,
            color: Theme.of(context).backgroundColor,
          ),
        ],
        color: Theme.of(context).primaryColor,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).backgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        height: 55,
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }

  Widget _buildMainPage() {
    return Column(
      children: <Widget>[
        SearchBarWidget(
          isSearchingHandler: _isSearchingHandler,
          searchQueryHandler: _searchRecipeHandler,
        ),
        const SizedBox(height: 5),
        _buildCategoryOrSearch(),
      ],
    );
  }

  Widget _buildCategoryOrSearch() {
    if (!_isSearching && _searchQuery.length == 0)
      return Expanded(
        child: Category(),
      );

    return Expanded(
      child: SearchResult(
        searchQuery: _searchQuery,
      ),
    );
  }

  void _searchRecipeHandler(String searchQuery) {
    debugPrint(searchQuery);
    setState(() {
      _searchQuery = searchQuery;
    });
  }

  void _isSearchingHandler(bool isSearchingInProgress) {
    if (_searchQuery.length > 0) return;

    setState(() {
      _isSearching = isSearchingInProgress;
    });
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 18,
        right: 18,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'Pinoy recipes',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 0.27,
                color: Colors.black45, // DesignCourseAppTheme.darkerText,
              ),
            ),
          ),
          Container(
            width: 60,
            height: 60,
            child: null, // Image.asset('assets/design_course/userImage.png'),
          )
        ],
      ),
    );
  }
}
