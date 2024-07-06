// ignore_for_file: prefer_const_constructors

import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditKorisnikModal extends StatefulWidget {
  final Korisnik korisnik;
  final Function handleEdit;

  const EditKorisnikModal({
    super.key,
    required this.korisnik,
    required this.handleEdit,
  });

  @override
  State<EditKorisnikModal> createState() => _EditKorisnikModalState();
}

class _EditKorisnikModalState extends State<EditKorisnikModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _korisnickoImeController;
  late TextEditingController _emailController;
  String? _selectedDominantnaRuka;
  int? _selectedSpolId;

  final List<String> ruke = ['Lijeva', 'Desna'];
  SearchResult<Spolovi> _spoloviResult = SearchResult<Spolovi>();

  @override
  void initState() {
    super.initState();
    _korisnickoImeController =
        TextEditingController(text: widget.korisnik.korisnickoIme);
    _emailController = TextEditingController(text: widget.korisnik.email);
    _selectedDominantnaRuka = widget.korisnik.dominantnaRuka ?? ruke.first;
    _selectedSpolId = null;

    loadSpolovi();
  }

  Future<void> loadSpolovi() async {
    var tmpData = await context.read<SpoloviProvider>().get();
    setState(() {
      _spoloviResult = tmpData;

      // Set the _selectedSpolId based on the spol value from korisnik
      Spolovi? selectedSpol = _spoloviResult.result.firstWhere(
        (spol) => spol.tipSpola == widget.korisnik.spol,
        orElse: () => Spolovi(),
      );
      _selectedSpolId = selectedSpol.id;
    });
  }

  @override
  void dispose() {
    _korisnickoImeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Korisnicko Ime',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: TextFormField(
                        controller: _korisnickoImeController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ovo polje je obavezno';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Unesite važeću email adresu';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dominantna Ruka',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedDominantnaRuka,
                        items: ruke.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedDominantnaRuka = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Spol',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: DropdownButtonFormField<int>(
                        value: _selectedSpolId,
                        items: _spoloviResult.result.map((Spolovi spol) {
                          return DropdownMenuItem<int>(
                            value: spol.id,
                            child: Text(spol.tipSpola!),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedSpolId = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.blue),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text(
            'Prekini',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.handleEdit(
                widget.korisnik.korisnikId!,
                _korisnickoImeController.text,
                _emailController.text,
                _selectedDominantnaRuka,
                _selectedSpolId,
                widget.korisnik.slika,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: const Text(
            'Spasi',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
