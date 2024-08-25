import 'package:donative_scanner/utils/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:donative_scanner/screens/qr_scanner_page.dart';
import 'package:donative_scanner/screens/reports_page.dart';

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
  static const List<String> _titles = <String>[
    'Campaña',
    'Escáner',
    'Reportes',
  ];
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    CampaignPage(),
    ScanQrPage(),
    ReportsPage(),
  ];

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
          style: const TextStyle(color: teal),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: lightTeal,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Campaña',
          ),
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
