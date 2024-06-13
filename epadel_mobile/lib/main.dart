import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:epadel_mobile/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51Ng87hEOriruq5sG3hxXaTNR88caRjGe00l9g16vZQGmQTjylGbM56AygMZ8eJFi6MXMbBcQdjr9X14CcKlsVtUK00IImzFKxq";
  Stripe.merchantIdentifier = 'any string works';
  Stripe.urlScheme = "flutterstripe";
  await Stripe.instance.applySettings();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TerenProvider()),
        ChangeNotifierProvider(create: (_) => KorisnikProvider()),
        ChangeNotifierProvider(create: (_) => RezervacijaProvider()),
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
      title: 'ePadel Mobile App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 59, 96, 61),
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        NavScreen.routeName: (context) => const NavScreen(),
        ReservationScreen.routeName: (context) => const ReservationScreen(),
        PaymentSuccessfullScreen.routeName: (context) =>
            const PaymentSuccessfullScreen(),
        ReservationSuccessfullScreen.routeName: (context) =>
            const ReservationSuccessfullScreen(),
       
      },
    );
  }
}
