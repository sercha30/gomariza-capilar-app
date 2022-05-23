import 'package:flutter/material.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:flutter_gomariza_capilar_app/ui/appointments_screen.dart';
import 'package:flutter_gomariza_capilar_app/ui/home_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    AppointmentsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: 'Mis citas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.email_outlined), label: 'Mensajería'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Perfil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), label: 'Ajustes'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        backgroundColor: CustomStyles.primaryColor,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
