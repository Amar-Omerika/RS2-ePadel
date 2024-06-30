// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/providers/korisnik_provider.dart';
import 'package:epadel_mobile/models/korisnik.dart';
import 'package:epadel_mobile/utils/util.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "/edit-profile";
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenScreenState();
}

class _EditProfileScreenScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  late KorisnikProvider _korisnikProvider;
  Korisnik? _korisnik;
  AuthProvider? _authProvider;
  final TextEditingController _korisnickoImeController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _dominantnaRuka = 'Desna';
    final ImagePicker _picker = ImagePicker();
   String? _pictureBase64;
     File? _picture;
  bool updateFailed = false;

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    _authProvider = context.read<AuthProvider>();
    loadData();
  }

  Future<void> loadData() async {
    Korisnik korisnik =
        await _korisnikProvider.getById(_authProvider!.getLoggedUserId());
    setState(() {
      _korisnik = korisnik;
      _korisnickoImeController.text = korisnik.korisnickoIme ?? '';
      _emailController.text = korisnik.email ?? '';
      _dominantnaRuka = korisnik.dominantnaRuka ?? 'Desna';
    });
  }

  Future<void> pickImage() async {
   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _picture = File(pickedFile.path);
        _pictureBase64 = base64String(_picture!.readAsBytesSync());
      });
    }
  }

  Future<void> saveData() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      Map<String, dynamic> data = {
        "ime": _korisnik!.ime,
        'prezime': _korisnik!.prezime,
        "korisnickoIme": _korisnickoImeController.text,
        "email": _emailController.text,
        'spol': _korisnik!.spol,
        "dominantnaRuka": _dominantnaRuka,
        "slika": _pictureBase64 ?? _korisnik!.slika,
      };
      print(data);
      try {
        await _korisnikProvider!.update(_korisnik!.korisnikId as int, data);
        if (context.mounted) {
          _showToast(context);
        }
        Authorization.username = _korisnickoImeController.text;
      } on Exception catch (exception) {
        String errorString =
            exception.toString().replaceFirst("Bad request ", "");
        print(errorString);
        // setState(() {
        //   error = errorString;
        // });
        formKey.currentState!.validate();
      }
    } else {
      setState(() {
        updateFailed = true;
      });
    }
  }
 void closeToast(context, scaffold) async {
    scaffold.hideCurrentSnackBar;
    await Future.delayed(const Duration(milliseconds: 400));
    Navigator.pop(context);
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Profil uspijesno azuriran!'),
        
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    ImageProvider profileImageProvider;

    if (_picture != null) {
      profileImageProvider = FileImage(_picture!);
    } else if (_korisnik != null &&
        _korisnik!.slika != null &&
        _korisnik!.slika!.isNotEmpty) {
      try {
        profileImageProvider = MemoryImage(base64Decode(_korisnik!.slika!));
      } catch (e) {
        profileImageProvider = AssetImage('assets/noprofile.jpeg');
      }
    } else {
      profileImageProvider = AssetImage('assets/noprofile.jpeg');
    }

    return Scaffold(
      backgroundColor: const Color(0xFF618264),
      appBar: AppBar(
        backgroundColor: const Color(0xFF618264),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFFB0D9B1),
          iconSize: 40,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: GestureDetector(
                  onTap: pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: profileImageProvider,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Korisnicko Ime',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              KorisnickoImeInputWidget(
                  korisnickoImeController: _korisnickoImeController),
              const SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              EmailWidget(emailController: _emailController),
              const SizedBox(height: 20),
              Text(
                'Dominantna Ruka',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownWidget(
                  dominantnaRuka: _dominantnaRuka,
                  onChanged: (value) {
                    setState(() {
                      _dominantnaRuka = value!;
                    });
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Cancel functionality
                      loadData(); // Reload the original data
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: saveData,
                    child: Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KorisnickoImeInputWidget extends StatelessWidget {
  const KorisnickoImeInputWidget({
    super.key,
    required TextEditingController korisnickoImeController,
  }) : _korisnickoImeController = korisnickoImeController;

  final TextEditingController _korisnickoImeController;

  bool isKorisnickoImeValid(String value) {
    RegExp regex = RegExp(r'^.{4,}$');
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          controller: _korisnickoImeController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Korisnicko Ime je obavezno';
            } else if (!isKorisnickoImeValid(value)) {
              return 'Korisnicko Ime mora imati najmanje 4 karaktera';
            }
            return null;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          ),
        ),
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  bool isEmailValid(String value) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
        caseSensitive: false);
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextFormField(
          controller: _emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Email je obavezan';
            } else if (!isEmailValid(value)) {
              return 'Unesite validnu email adresu';
            }
            return null;
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          ),
        ),
      ),
    );
  }
}

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required String dominantnaRuka,
    required this.onChanged,
  }) : _dominantnaRuka = dominantnaRuka;

  final String _dominantnaRuka;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButtonFormField<String>(
          value: _dominantnaRuka,
          items: ['Desna', 'Lijeva'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          ),
        ),
      ),
    );
  }
}
