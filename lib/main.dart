import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ui/home_page.dart';
import 'ui/favourite_page.dart';

void main() {
   runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Masnoon Dua',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _childWidget = [
    HomePage(),
    FavouritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childWidget[_currentIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(brightness: Brightness.dark),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              label: 'Favorite',
            ),
          ],
        ),
      ),
    );
    
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
