import 'package:flutter/material.dart';
import 'package:donative_scanner/screens/qr_scanner_page.dart';
import 'package:donative_scanner/screens/reports_page.dart';
import 'package:donative_scanner/utils/color_constants.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ScreenSelector(),
    );
  }
}

class ScreenSelector extends StatefulWidget {
  const ScreenSelector({super.key});

  @override
  State<ScreenSelector> createState() => _ScreenSelectorState();
}

class _ScreenSelectorState extends State<ScreenSelector> {
  // changing content
  static const List<String> _titles = <String>[
    'Escáner',
    'Reportes',
  ];
  static const List<Widget> _widgetOptions = <Widget>[
    ScanQrPage(),
    ReportsPage(),
  ];

  List<Widget> _getActions(int index) {
    switch (index) {
      case 0:
        return [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.history,
                size: 26.0,
                color: teal,
              ),
            ),
          ),
        ];
      default:
        return [];
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: teal);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: teal,
      appBar: AppBar(
        backgroundColor: lightTeal,
        title: Text(
          _titles[_selectedIndex],
          style: optionStyle,
        ),
        actions: _getActions(_selectedIndex),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightTeal,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Escáner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: 'Reportes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
