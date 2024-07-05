import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/providers/spolovi_provider.dart'; // Import the provider
import 'package:epadel_mobile/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  late AuthProvider _authProvider;
  late SpoloviProvider _spoloviProvider; // Add SpoloviProvider
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  int? selectedSpolId = 1; 
  String? dominantnaRuka = 'Desna';
  List<int> uloge = [2];
  SearchResult<Spolovi> _spoloviResult = SearchResult<Spolovi>();
  bool registrationFailed = false;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    _spoloviProvider = context.read<SpoloviProvider>();
    loadSpolovi();
  }
  Future<void> loadSpolovi() async {
    var tmpData = await _spoloviProvider.get();
    setState(() {
      _spoloviResult = tmpData;
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
                    const SizedBox(height: 20),
                    Consumer<SpoloviProvider>(
                      builder: (context, provider, child) {
                        return DropdownButtonFormField<int>(
                          value: selectedSpolId,
                          items:_spoloviResult.result.map((spol) {
                            return DropdownMenuItem(
                              value: spol.id,
                              child: Text(spol.tipSpola!),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSpolId = value;
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Spol',
                          ),
                        );
                      },
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
                            'lozinka': password!,
                            'spoloviId': selectedSpolId!,
                            'dominantnaRuka': dominantnaRuka!,
                            'uloge': [2]
                          };
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
