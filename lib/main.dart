import 'package:flutter/material.dart';
import 'ui/profile_page.dart';
import 'ui/home_page.dart';
import 'ui/favourite_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Masnoon Dua',
      home: MyHomePage(),
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
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childWidget[_currentIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(accentColor: Colors.white, brightness: Brightness.dark),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              title: new Text('Favorite'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), title: Text('Profile'))
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
