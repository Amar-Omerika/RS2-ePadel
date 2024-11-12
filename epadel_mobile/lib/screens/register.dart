import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/screens/screens.dart';
import 'package:epadel_mobile/utils/util.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  late AuthProvider _authProvider;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? email;
  String? defaultImageBase64;
  int? selectedSpolId = 1;
  String? dominantnaRuka = 'Desna';
  List<int> uloge = [2];
  final List<Map<String, dynamic>> spolovi = [
    {'id': 1, 'tipSpola': 'Muško'},
    {'id': 2, 'tipSpola': 'Žensko'}
  ];
  bool registrationFailed = false;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    _loadDefaultImage();
  }

  void _loadDefaultImage() async {
    final ByteData bytes = await rootBundle.load('assets/noprofile.jpeg');
    final buffer = bytes.buffer;
    final base64Image = base64String(Uint8List.view(buffer));
    setState(() {
      defaultImageBase64 = base64Image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                      "Dobrodosli na ePadel",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (newValue) => firstName = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ovo polje je obavezno";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Ime',
                        hintText: 'Ime',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (newValue) => lastName = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ovo polje je obavezno";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Prezime',
                        hintText: 'Prezime',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (newValue) => userName = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ovo polje je obavezno";
                        }
                        if (!RegExp(r'^.{4,}$').hasMatch(value)) {
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
                      onSaved: (newValue) => email = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ovo polje je obavezno";
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Unesite važeću email adresu';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onSaved: (newValue) => password = newValue,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Ovo polje je obavezno";
                        }
                        if (!RegExp(r'^.{8,}$').hasMatch(value)) {
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
                    const SizedBox(height: 20),
                    DropdownButtonFormField<int>(
                      value: selectedSpolId,
                      items: spolovi.map((spol) {
                        return DropdownMenuItem<int>(
                          value: spol['id'],
                          child: Text(spol['tipSpola']),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedSpolId = newValue;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Spol',
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: dominantnaRuka,
                      items: ['Desna', 'Lijeva']
                          .map((label) => DropdownMenuItem(
                                child: Text(label),
                                value: label,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          dominantnaRuka = value!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Dominantna ruka',
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (registrationFailed)
                      const Text(
                        'Registration Failed',
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          registrationFailed = false;
                        });
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          Map user = {
                            'ime': firstName!,
                            'prezime': lastName!,
                            'korisnickoIme': userName!,
                            'email': email!,
                            'password': password!,
                            'spol': selectedSpolId!,
                            'dominantnaRuka': dominantnaRuka!,
                            'uloge': [2],
                            'slika': defaultImageBase64
                          };
                          print(user);
                          try {
                            var data = await _authProvider.register(user);
                            if (context.mounted) {
                              Navigator.popAndPushNamed(
                                  context, LoginScreen.routeName);
                            }
                          } on Exception catch (error) {
                            setState(() {
                              registrationFailed = true;
                            });
                            print(error.toString());
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
