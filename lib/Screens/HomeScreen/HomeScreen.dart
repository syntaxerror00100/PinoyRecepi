import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../Widgets/SearchBarWidget.dart';
import 'Category.dart';
import 'Favorites.dart';
import 'SearchResult.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            color: Colors.black45, // DesignCourseAppTheme.darkerText,
          ),
        ),
      ),
      body: PageView(
        children: <Widget>[
          _buildMainPage(),
          Favorties(),
        ],
        controller: _pageController,
        pageSnapping: true,
        //physics: BouncingScrollPhysics(), // NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
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
