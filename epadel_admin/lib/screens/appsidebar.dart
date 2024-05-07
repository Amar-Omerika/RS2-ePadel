import 'package:flutter/material.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.green,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.green,
            child: const Text(
              'ePadel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Tereni'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TereniScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Korisnici'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => KorisniciScreen()),
              );
            },
          ),
          ListTile(
            title: const Text('Rezervacije'),
            onTap: () {
              // Implement navigation to Rezervacije screen
            },
          ),
        ],
      ),
    );
  }
}
