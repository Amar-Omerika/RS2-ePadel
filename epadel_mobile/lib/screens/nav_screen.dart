import 'package:epadel_mobile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'screens.dart'; // Ensure this import points to your screens

class NavScreen extends StatefulWidget {
  static const routeName = '/home';
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const TereniSaPopustom(),
    const ProfileScreen() 
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.discount_rounded,
    Icons.account_circle
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _icons.map((IconData icon) {
          return BottomNavigationBarItem(
            icon: Icon(icon, size: 30),
            label: '', // Add labels if needed
          );
        }).toList(),
        selectedItemColor: const Color(0XFFB0D9B1),
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.green[500],
      ),
    );
  }
}
