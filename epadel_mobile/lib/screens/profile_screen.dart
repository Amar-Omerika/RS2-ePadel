// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:epadel_mobile/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/providers/korisnik_provider.dart';
import 'package:epadel_mobile/models/korisnik.dart';
import 'package:epadel_mobile/utils/util.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    ImageProvider profileImageProvider;

    if (_korisnik != null &&
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
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                backgroundImage: profileImageProvider,
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
            Positioned(
                right: 10,
                bottom: 10,
                child: InkWell(
                  onTap: () {
                    _authProvider!.logout();
                    Navigator.pushNamed(context, LoginScreen.routeName);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: Center(
                        child: Text(
                          'Log out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
