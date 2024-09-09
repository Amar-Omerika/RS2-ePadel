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

  String? korisnickoImeError;
  String? emailError;

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

  void _validateForm() {
    setState(() {
      korisnickoImeError = _korisnickoImeController.text.isEmpty
          ? 'Korisnicko Ime je obavezno'
          : (_korisnickoImeController.text.length < 4
              ? 'Korisnicko Ime mora imati najmanje 4 karaktera'
              : null);

      emailError = _emailController.text.isEmpty
          ? 'Email je obavezan'
          : (!_isEmailValid(_emailController.text)
              ? 'Unesite validnu email adresu'
              : null);
    });
  }

  bool _isEmailValid(String value) {
    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
        caseSensitive: false);
    return regex.hasMatch(value);
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
    _validateForm();

    if (korisnickoImeError == null && emailError == null) {
      formKey.currentState!.save();
      Map<String, dynamic> data = {
        "ime": _korisnik!.ime,
        'prezime': _korisnik!.prezime,
        "korisnickoIme": _korisnickoImeController.text,
        "email": _emailController.text,
        'spoloviId': 1,
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
        formKey.currentState!.validate();
      }
    } else {
      setState(() {
        updateFailed = true;
      });
    }
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
                korisnickoImeController: _korisnickoImeController,
                error: korisnickoImeError,
              ),
              const SizedBox(height: 20),
              Text(
                'Email',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              EmailWidget(
                emailController: _emailController,
                error: emailError,
              ),
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
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                     style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),      
                    onPressed: () {
                      loadData(); 
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,                 
                      ),                  
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
    this.error,
  }) : _korisnickoImeController = korisnickoImeController;

  final TextEditingController _korisnickoImeController;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: _korisnickoImeController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                error!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    required TextEditingController emailController,
    this.error,
  }) : _emailController = emailController;

  final TextEditingController _emailController;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                error!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ),
      ],
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
