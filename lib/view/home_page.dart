import 'package:flutter/material.dart';
import 'package:test_dot_technical_app/view/gallery_screen.dart';
import 'package:test_dot_technical_app/view/place_screen.dart';
import 'package:test_dot_technical_app/view/user_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: unused_field
  int _selectedNavBar = 0;

  final List<Widget> _listPage = [
    const PlaceScreen(),
    const GalleryScreen(),
    const UserScreen(),
  ];

  void _changeSelect(int index) {
    setState(() {
      _selectedNavBar = index;
    });
  }
  String _checkTitle(int index){
    switch (index) {
      case 0:
        return 'Place';
       case 1:
        return 'Gallery';
       case 2:
        return 'User';
      default:
      return 'Home Page';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(_checkTitle(_selectedNavBar)),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey,
          child: _listPage[_selectedNavBar],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'PLACE',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'GALLERY',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'USER',
            ),
          ],
          currentIndex: _selectedNavBar,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: _changeSelect,
        ));
  }
}
