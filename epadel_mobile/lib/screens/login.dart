import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/screens/screens.dart';
import 'package:epadel_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

RegExp regexLozinka = RegExp(r'^.{8,}$');
RegExp regexKorisnicko = RegExp(r'^.{4,}$');

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late AuthProvider _authProvider;
  String? userName;
  String? password;
  String? errorMessage;
  bool loginFailed = false;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
         automaticallyImplyLeading: false,        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 500,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  const Text(
                    "Dobrodošli na ePadel", // Your custom text
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onSaved: (newValue) => userName = newValue,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ovo polje je obavezno";
                      }
                      if (!regexKorisnicko.hasMatch(value)) {
                        return 'Korisničko ime mora sadržavati najmanje 4 karaktera!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Korisničko ime',
                      hintText: 'Korisničko ime',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onSaved: (newValue) => password = newValue,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Ovo polje je obavezno";
                      }
                      if (!regexLozinka.hasMatch(value)) {
                        return 'Lozinka mora sadržavati 8 karaktera!';
                      }
                      return null;
                    },
                    obscureText: true,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      labelText: 'Lozinka',
                      hintText: '********',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (loginFailed)
                    Text(
                      errorMessage ?? '',
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor:
                          Colors.green, // Set the background color to green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set the radius of the corners
                      ),
                    ),
                    onPressed: () async {
                      setState(() {
                        loginFailed = false;
                      });
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Map<String, String> user = {
                          'korisnickoIme': userName!,
                          'lozinka': password!
                        };
                        try {
                          var data = await _authProvider!.login(user);
                          if (context.mounted) {
                            _authProvider!
                                .setParameters(data!.korisnikId!.toInt());
                            Authorization.username = userName;
                            Authorization.password = password;
                            Navigator.popAndPushNamed(
                                context, NavScreen.routeName);
                          }
                        } on Exception catch (error) {
                          print(error.toString());
                          if (error.toString().contains("Exception")) {
                            setState(() {
                              loginFailed = true;
                              errorMessage = error.toString()
                                 .substring(86, error.toString().length - 2);
                            });
                          }
                        }
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white, // Set the text color to white
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Nemate račun?',
                        style: TextStyle(
                            color: Color.fromARGB(225, 195, 178, 178)),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, RegisterScreen.routeName),
                        child: const Text(
                          'Registruj se ovdje.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
