// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EditObavijestModal extends StatefulWidget {
  final int id;
  final String naslov;
  final String sadrzaj;
  final Function handleEdit;

  const EditObavijestModal({
    super.key,
    required this.id,
    required this.naslov,
    required this.sadrzaj,
    required this.handleEdit,
  });

  @override
  State<EditObavijestModal> createState() => _EditObavijestModalState();
}

class _EditObavijestModalState extends State<EditObavijestModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _naslovController;
  late TextEditingController _sadrzajController;

  String? _naslovError;
  String? _sadrzajError;

  @override
  void initState() {
    super.initState();
    _naslovController = TextEditingController(text: widget.naslov);
    _sadrzajController = TextEditingController(text: widget.sadrzaj);
  }

  void _validateForm() {
    setState(() {
      _naslovError = _naslovController.text.isEmpty ? 'Ovo polje je obavezno' : null;
      _sadrzajError = _sadrzajController.text.isEmpty ? 'Ovo polje je obavezno' : null;
    });
  }

  @override
  void dispose() {
    _naslovController.dispose();
    _sadrzajController.dispose();
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
                                'Naslov Obavijesti',
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
                                  controller: _naslovController,
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
                                      _naslovError = null;
                                    });
                                  },
                                ),
                              ),
                              if (_naslovError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _naslovError!,
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
                                'Sadrzaj Obavijesti',
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
                                  controller: _sadrzajController,
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
                                      _sadrzajError = null;
                                    });
                                  },
                                ),
                              ),
                              if (_sadrzajError != null)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _sadrzajError!,
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
            if (_naslovError == null && _sadrzajError == null) {
              widget.handleEdit(
                widget.id,
                _naslovController.text,
                _sadrzajController.text,
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