import 'package:flutter/material.dart';
import 'AddMenuScreen.dart';
import 'HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Warung',
      home: HomePage(
        selectedIndex: 0,
      ),
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
              selectionColor: Colors.teal[400],
              cursorColor: Colors.grey,
              selectionHandleColor: Colors.teal[400])),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.selectedIndex}) : super(key: key);

  int selectedIndex;
  int cek = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AddMenuScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Tambah'),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.teal[400],
        onTap: onItemTapped,
      ),
    );
  }
}
