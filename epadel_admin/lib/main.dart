import 'package:epadel_admin/providers/auth_provider.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/main_navigation_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:flutter/material.dart';
import 'package:epadel_admin/screens/login_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),       
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ePadel Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        '/': (context) => LoginScreen(),
        MainNavigationScreen.routeName: (context) =>
            const MainNavigationScreen(),
        TereniScreen.routeName: (context) => const TereniScreen(),
        KorisniciScreen.routeName: (context) => const KorisniciScreen(),
      },
    );
  }
}