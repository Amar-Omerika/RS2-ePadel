// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EditPartneriModal extends StatefulWidget {
  final int id;
  final String naziv;
  final String deskripcija;
  final Function handleEdit;

  const EditPartneriModal({
    super.key,
    required this.id,
    required this.naziv,
    required this.deskripcija,
    required this.handleEdit,
  });

  @override
  State<EditPartneriModal> createState() => _EditPartneriModalModalState();
}

class _EditPartneriModalModalState extends State<EditPartneriModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nazivController;
  late TextEditingController _deskripcijaController;

  String? _nazivError;
  String? _deskripcijaError;

  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.naziv);
    _deskripcijaController = TextEditingController(text: widget.deskripcija);
  }

  void _validateForm() {
    setState(() {
      _nazivError = _nazivController.text.isEmpty ? 'Ovo polje je obavezno' : null;
      _deskripcijaError = _deskripcijaController.text.isEmpty ? 'Ovo polje je obavezno' : null;
    });
  }

  @override
  void dispose() {
    _nazivController.dispose();
    _deskripcijaController.dispose();
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Naziv Partnera',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: 80, // Set a maximum height for the TextFormField
                                ),
                                child: TextFormField(
                                  controller: _nazivController,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _nazivError = null;
                                    });
                                  },
                                ),
                              ),
                              if (_nazivError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _nazivError!,
                                      style: TextStyle(color: Colors.red, fontSize: 12),
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
                                'Deskripcija',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                constraints: BoxConstraints(
                                  maxHeight: 200, // Set a maximum height for the TextFormField
                                ),
                                child: SingleChildScrollView(
                                  child: TextFormField(
                                    controller: _deskripcijaController,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(8.0),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _deskripcijaError = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              if (_deskripcijaError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _deskripcijaError!,
                                      style: TextStyle(color: Colors.red, fontSize: 12),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
            _validateForm();
            if (_nazivError == null && _deskripcijaError == null) {
              widget.handleEdit(
                widget.id,
                _nazivController.text,
                _deskripcijaController.text,
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