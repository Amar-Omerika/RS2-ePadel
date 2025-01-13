// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTrenerModal extends StatefulWidget {
  final int id;
  final String imePrezime;
  final String bio;
  final String kontaktTel;
  final Function handleEdit;

  const EditTrenerModal({
    super.key,
    required this.id,
    required this.imePrezime,
    required this.bio,
    required this.kontaktTel,
    required this.handleEdit,
  });

  @override
  State<EditTrenerModal> createState() => _EditTrenerModalState();
}

class _EditTrenerModalState extends State<EditTrenerModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _imePrezimeController;
  late TextEditingController _bioController;
  late TextEditingController _kontaktTelController;

  String? _imePrezimeError;
  String? _bioError;
  String? _kontaktTelError;

  @override
  void initState() {
    super.initState();
    _imePrezimeController = TextEditingController(text: widget.imePrezime);
    _bioController = TextEditingController(text: widget.bio);
    _kontaktTelController = TextEditingController(text: widget.kontaktTel);
  }

  void _validateForm() {
    setState(() {
      _imePrezimeError = _imePrezimeController.text.isEmpty ? 'Ovo polje je obavezno' : null;
      _bioError = _bioController.text.isEmpty ? 'Ovo polje je obavezno' : null;
      _kontaktTelError = _kontaktTelController.text.isEmpty || !RegExp(r'^\d{3}-\d{3}-(\d{4}|\d{3})$').hasMatch(_kontaktTelController.text)
          ? 'KontaktTel mora biti u obliku 06X-XXX-XXX !'
          : null;
    });
  }

  @override
  void dispose() {
    _imePrezimeController.dispose();
    _bioController.dispose();
    _kontaktTelController.dispose();
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
                                'Ime Prezime',
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
                                child: TextFormField(
                                  controller: _imePrezimeController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _imePrezimeError = null;
                                    });
                                  },
                                ),
                              ),
                              if (_imePrezimeError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _imePrezimeError!,
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
                                'Bio',
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
                                    controller: _bioController,
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
                                        _bioError = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              if (_bioError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _bioError!,
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
                                'Kontakt Tel',
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
                                child: TextFormField(
                                  controller: _kontaktTelController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[\d-]')),
                                    LengthLimitingTextInputFormatter(12),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _kontaktTelError = null;
                                    });
                                  },
                                ),
                              ),
                              if (_kontaktTelError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _kontaktTelError!,
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
            if (_imePrezimeError == null && _bioError == null && _kontaktTelError == null) {
              widget.handleEdit(
                widget.id,
                _imePrezimeController.text,
                _bioController.text,
                _kontaktTelController.text,
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