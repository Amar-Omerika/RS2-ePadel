import 'package:flutter/material.dart';

RegExp regexLozinka = RegExp(r'^.{8,}$');
RegExp regexKorisnicko = RegExp(r'^.{4,}$');

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF79AC78),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'EPADEL ADMIN',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Korisničko ime',
                    hintText: 'Korisničko ime',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ovo polje je obavezno";
                    }
                    if (!regexKorisnicko.hasMatch(value)) {
                      return 'Korisničko ime mora sadržavati najmanje 4 karaktera!';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Lozinka',
                    hintText: '******',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Ovo polje je obavezno";
                    }
                    if (!regexLozinka.hasMatch(value)) {
                      return 'Lozinka mora sadržavati najmanje 8 karaktera!';
                    }
                    return null;
                  },
                  obscureText: true,
                  autocorrect: false,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Color(0xFF79AC78),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10, // Set the border radius here
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color:
                          Color(0xFFFFFFFF), // Text color (white in this case)
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ], // Removed extra closing parenthesis here
            ),
          ),
        ),
      ),
    );
  }
}
