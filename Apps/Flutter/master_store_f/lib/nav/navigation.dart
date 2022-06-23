import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import "../screens/Ads/ads_screen.dart";
import '../screens/New/create_new_ad_screen.dart';
import '../screens/Profile/profile_screen.dart';
import "../screens/Search/search_screen.dart";
import '../store/app_state.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  @override
  _Navigation createState() => _Navigation();
}

class _Navigation extends State<Navigation> {
  final CupertinoTabController _controller = CupertinoTabController();

  @override
  Widget build(BuildContext context) {
    return (StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state) {
        return (CupertinoTabScaffold(
          controller: _controller,
          tabBar: CupertinoTabBar(
            activeColor: Colors.black,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.ad_units),
                label: 'Ads',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'New',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(
                    child: AdsScreen(),
                  );
                });
              case 1:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(
                    child: SearchScreen(),
                  );
                });
              case 2:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(
                    child: CreateNewAdScreen(),
                  );
                });
              case 3:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(
                    child: ProfileScreen(),
                  );
                });
              default:
                return CupertinoTabView(builder: (context) {
                  return const CupertinoPageScaffold(
                    child: ProfileScreen(),
                  );
                });
            }
          },
        ));
      },
    ));
  }
}
