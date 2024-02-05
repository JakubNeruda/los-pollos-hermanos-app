import 'package:flutter/material.dart';
import 'package:los_pollos_hermanos/pages/order/order_entry_page.dart';
import 'package:los_pollos_hermanos/pages/other/other_page.dart';

import 'pages/coupon/coupons_page.dart';
import 'pages/menu/menu_page.dart';
import 'pages/retaurant/restaurant_page.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => NavigationBarApp(),
      },
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class NavigationBarApp extends StatefulWidget {
  final menuKey = GlobalKey<NavigatorState>();

  NavigationBarApp({super.key});

  @override
  State<NavigationBarApp> createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  int currentPageIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() => currentPageIndex = index);
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: _navigationDestinationList(),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: Column(
          key: ValueKey(currentPageIndex),
          children: [
            Expanded(
              child: <Widget>[
                WillPopScope(
                  onWillPop: () async => false,
                  child: Navigator(
                    key: widget.menuKey,
                    onGenerateRoute: (route) => MaterialPageRoute(
                      settings: route,
                      builder: (context) => MenuPage(
                        navigatorKey: widget.menuKey,
                      ),
                    ),
                  ),
                ),
                CouponsPage(),
                OrderEntryPage(),
                RestaurantPage(),
                OtherPage(),
              ][currentPageIndex],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _navigationDestinationList() {
    return const <Widget>[
      NavigationDestination(
        icon: Icon(Icons.restaurant),
        label: 'Menu',
      ),
      NavigationDestination(
        icon: Icon(Icons.money),
        label: 'Coupons',
      ),
      NavigationDestination(
        icon: Icon(Icons.note_alt_outlined),
        label: 'Order',
      ),
      NavigationDestination(
        icon: Icon(Icons.table_bar),
        label: 'Restaurants',
      ),
      NavigationDestination(
        icon: Icon(Icons.apps),
        label: 'Other',
      ),
    ];
  }
}
