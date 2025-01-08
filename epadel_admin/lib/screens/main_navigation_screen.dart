import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/login_screen.dart';
import 'package:epadel_admin/screens/obavijesti_screen.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final String label;
  final Widget widget;

  NavigationItem({required this.label, required this.widget});
}

class MainNavigationScreen extends StatefulWidget {
  static const routeName = "/home";
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<NavigationItem> _navigationItems = [
    NavigationItem(label: 'Tereni', widget: const TereniScreen()),
    NavigationItem(label: 'Korisnici', widget: const KorisniciScreen()),
    NavigationItem(label: 'Rezervacije', widget: const RezervacijeScreen()),
    NavigationItem(label: 'Report', widget: const ReportScreen()),
    NavigationItem(label: 'Obavijesti', widget: const ObavijestiScreen()),
    NavigationItem(label: 'Login', widget: const LoginScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navigationItems[_selectedIndex].widget,
      ),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: _navigationItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_navigationItems[index].label),
              selected: _selectedIndex == index,
              onTap: () {
                _onItemTapped(index);
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
    );
  }
}
