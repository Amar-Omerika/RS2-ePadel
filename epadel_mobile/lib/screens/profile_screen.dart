import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/providers/korisnik_provider.dart';
import 'package:epadel_mobile/models/korisnik.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  late KorisnikProvider _korisnikProvider;
  Korisnik? _korisnik;
  AuthProvider? _authProvider;
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _dominantHand = 'Desna';

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
      _nicknameController.text = korisnik.korisnickoIme ?? '';
      _emailController.text = korisnik.email ?? '';
      _dominantHand = korisnik.dominantnaRuka ?? 'Desna';
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.grey[800],
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _dominantHand,
              items: ['Desna', 'Lijeva'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _dominantHand = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Dominantna ruka',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save action
                Korisnik updatedKorisnik = Korisnik(
                  korisnikId: _korisnik?.korisnikId,
                  korisnickoIme: _nicknameController.text,
                  email: _emailController.text,
                  dominantnaRuka: _dominantHand,
                );
                _korisnikProvider.update(updatedKorisnik as int);
              },
              child: const Text('Save'),
              // style: ElevatedButton.styleFrom(
              //   primary: Colors.green[900],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
