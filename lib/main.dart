/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:navstackexer/calendarView.dart';
import 'subWidgets.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;

  List _selectedMenu = [
    CalendarView(),
    home(),
    StackOver(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildCurvedNavigationBar(),
      body: Container(
        child: _selectedMenu.elementAt(_selectedIndex),
      ),
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      index: 1,
      height: 70,
      backgroundColor: Colors.black,
      buttonBackgroundColor: Colors.black,
      color: Colors.black,
      animationDuration: const Duration(milliseconds: 100),
      animationCurve: Curves.easeInOutQuart,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: [
        Icon(Icons.home,
            size: (_selectedIndex == 0) ? 33 : 20,
            color: (_selectedIndex == 0) ? Colors.orange : Colors.white),
        Icon(Icons.blur_on,
            size: (_selectedIndex == 1) ? 40 : 20,
            color: (_selectedIndex == 1) ? Colors.orange : Colors.white),
        Icon(Icons.edit,
            size: (_selectedIndex == 2) ? 33 : 20,
            color: (_selectedIndex == 2) ? Colors.orange : Colors.white),
      ],
    );
  }
}

Widget home() {
  void _gotoSetting() {}
  return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _gotoSetting,
        child: const Icon(Icons.notifications_none),
        backgroundColor: Color(0xffef4b3d),
      ),
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                0.1,
                0.9
              ],
                  colors: [
                Colors.indigo,
                Colors.orange,
              ])),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "서울시 서대문구 연희동",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                            Icon(Icons.expand_more, color: Colors.white)
                          ],
                        ),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      ),
                      Container(
                        child: Text(
                          "일몰까지 37분 남았습니다.",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                      )

                      // Text(
                      //   "일몰까지 37분 남았습니다.",
                      //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Container(
                    child: Image(
                        image: AssetImage('assets/sun.png'), fit: BoxFit.fill)),
                flex: 4,
              ),
              Expanded(
                child: Container(
                  child: Image(
                    image: AssetImage('assets/city_view.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                flex: 6,
              )
            ],
          )));
}

Widget backgroundExercise() {
  return Scaffold(
    body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange,
            Colors.white,
          ],
        )),
        child: Center(
          child: Image.asset(
            "assets/sun.png",
            width: 200,
            height: 200,
          ),
        ),
      ),
    ),
  );
}

//구분선

/*
/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified, size: 40),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
*/
