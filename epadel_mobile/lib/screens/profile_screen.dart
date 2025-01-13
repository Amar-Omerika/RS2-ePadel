// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:epadel_mobile/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/providers/korisnik_provider.dart';
import 'package:epadel_mobile/models/korisnik.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late KorisnikProvider _korisnikProvider;
  Korisnik? _korisnik;
  AuthProvider? _authProvider;
  final TextEditingController _korisnickoImeController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _dominantnaRuka = 'Desna';

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    _authProvider = context.read<AuthProvider>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      backgroundColor: const Color(0xFF618264),
      appBar: AppBar(
        backgroundColor: const Color(0xFF618264),
        leading: IconButton(
          icon: Icon(Icons.history),
          color: Color(0xFFB0D9B1),
          iconSize: 40,
          onPressed: () {
               Navigator.pushNamed(context, HistoryReservationScreen.routeName);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            color: Color(0xFFB0D9B1),
            iconSize: 40,
            onPressed: () async {
              await Navigator.pushNamed(context, EditProfileScreen.routeName);
              loadData(); // Reload the data after returning from EditProfileScreen
            },
          ),
        ],
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
            DropdownWidget(dominantnaRuka: _dominantnaRuka),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RecommendScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[500],
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Center(
                      child: Text(
                        'Prikazi preporucene terene',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PartneriScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green[500],
                      borderRadius: BorderRadius.circular(5)),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Center(
                      child: Text(
                        'Prikazi oficijalne partnere',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
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
              ),
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _korisnickoImeController,
          enabled: false,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: _emailController,
          enabled: false,
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
  }) : _dominantnaRuka = dominantnaRuka;

  final String _dominantnaRuka;

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
          onChanged: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          ),
          disabledHint: Text(_dominantnaRuka),
        ),
      ),
    );
  }
}
