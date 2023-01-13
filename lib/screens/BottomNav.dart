import 'package:flutter/material.dart';
import 'package:mantenedor_lossan/screens/Dias.dart';
import 'package:mantenedor_lossan/screens/Muebles.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    Dias(),
    Muebles(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.listBox),
            label: 'Días',
            
            
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.hammer),
            label: 'Muebles',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index){
          print(index);
          setState(() {
            _currentIndex = index;
          });
        }
      ),
    );
  }
}