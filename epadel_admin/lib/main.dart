import 'package:epadel_admin/providers/auth_provider.dart';
import 'package:epadel_admin/providers/feedback_provider.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:epadel_admin/providers/report_provider.dart';
import 'package:epadel_admin/screens/feedback_screen.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/main_navigation_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:flutter/material.dart';
import 'package:epadel_admin/screens/login_screen.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),  
        ChangeNotifierProvider(create: (_) => TerenProvider()), 
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
        ChangeNotifierProvider(create: (_) => FeedbackProvider()),
        ChangeNotifierProvider(create: (_) => GradoviProvider()),
        ChangeNotifierProvider(create: (_) => ReportProvider()),
        ChangeNotifierProvider(create: (_) => SpoloviProvider()),
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
        primaryColor: const Color.fromARGB(255, 59, 96, 61),
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        '/': (context) => LoginScreen(),
        MainNavigationScreen.routeName: (context) =>
            const MainNavigationScreen(),
        TereniScreen.routeName: (context) => const TereniScreen(),
        KorisniciScreen.routeName: (context) => const KorisniciScreen(),
        RezervacijeScreen.routeName: (context) => const RezervacijeScreen(),
        FeedbackScreen.routeName: (context) => const FeedbackScreen(),
      },
    );
  }
}
