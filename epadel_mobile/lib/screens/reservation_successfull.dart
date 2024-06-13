// ignore_for_file: prefer_const_constructors

import 'package:epadel_mobile/screens/screens.dart';
import 'package:flutter/material.dart';

class ReservationSuccessfullScreen extends StatelessWidget {
  const ReservationSuccessfullScreen({super.key});
  static const routeName = '/reservation-successfull';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  'Rezervacija Uspiješna!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Hvala vam na korištenju naše aplikacije. Vaša rezervacija je uspješno završena.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, NavScreen.routeName),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green, // Button color
                    backgroundColor: Colors.white, // Text color
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Go to Home',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
