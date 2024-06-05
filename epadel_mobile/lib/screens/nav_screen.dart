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
    const HomeScreen(), // Replace with your actual LeaderboardScreen
    const HomeScreen() // Replace with your actual ProfileScreen
  ];

  final List<IconData> _icons = const [
    Icons.home,
    Icons.bar_chart_outlined,
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
        selectedItemColor: Colors.green[900],
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.green[500],
      ),
    );
  }
}
