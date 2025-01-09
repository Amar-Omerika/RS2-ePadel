// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddObavijestModal extends StatefulWidget {
  final Function handleAdd;

  const AddObavijestModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddObavijestModal> createState() => _AddObavijestModalState();
}

class _AddObavijestModalState extends State<AddObavijestModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? naslov;
  String? sadrzaj;

  String? naslovError = null;
  String? sadrzajError = null;

  @override
  void initState() {
    super.initState();
  }

  void _validateForm() {
    setState(() {
      naslovError =
          naslov == null || naslov!.isEmpty ? 'Ovo polje je obavezno' : null;
      sadrzajError =
          sadrzaj == null || sadrzaj!.isEmpty ? 'Ovo polje je obavezno' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Form(
          key: formKey,
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
                                  maxLines: null, // Allows unlimited lines
                                  keyboardType: TextInputType
                                      .multiline, // Allows multiline input
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      naslov = value;
                                      naslovError = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (naslovError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                naslovError!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
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
                                  maxLines: null, // Allows unlimited lines
                                  keyboardType: TextInputType
                                      .multiline, // Allows multiline input
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      sadrzaj = value;
                                      sadrzajError = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (sadrzajError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                naslovError!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
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
            if (naslovError == null && sadrzajError == null) {
              widget.handleAdd(
                naslov,
                sadrzaj,
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
