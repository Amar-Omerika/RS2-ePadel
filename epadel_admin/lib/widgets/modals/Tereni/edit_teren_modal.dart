// ignore_for_file: prefer_const_constructors
import 'package:epadel_admin/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditTerenModal extends StatefulWidget {
  final Teren teren;
  final Function handleEdit;

  const EditTerenModal({
    super.key,
    required this.teren,
    required this.handleEdit,
  });

  @override
  State<EditTerenModal> createState() => _EditTerenModalState();
}

class _EditTerenModalState extends State<EditTerenModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nazivController;
  late TextEditingController _brojTerenaController;
  late TextEditingController _cijenaController;
  late TextEditingController _lokacijaController;
  late TextEditingController _cijenaPopustaController;

  int? _selectedTipTerena;
  String? _selectedPopust;

  final List<Map<String, dynamic>> vrstePodloge = [
    {"tipTerenaId": 1, "naziv": "Guma"},
    {"tipTerenaId": 2, "naziv": "Trava"},
    {"tipTerenaId": 3, "naziv": "Beton"}
  ];

  bool get isSaveButtonDisabled {
    if (_selectedPopust == 'Da' &&
        _cijenaPopustaController.text.isNotEmpty &&
        _cijenaController.text.isNotEmpty) {
      int cijenaPopusta = int.tryParse(_cijenaPopustaController.text) ?? 0;
      int cijena = int.tryParse(_cijenaController.text) ?? 0;
      return cijenaPopusta > cijena;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.teren.naziv);
    _brojTerenaController =
        TextEditingController(text: widget.teren.brojTerena?.toString());
    _cijenaController =
        TextEditingController(text: widget.teren.cijena?.toString());
    _lokacijaController = TextEditingController(text: widget.teren.lokacija);
    _cijenaPopustaController =
        TextEditingController(text: widget.teren.cijenaPopusta?.toString());
    _selectedTipTerena = widget.teren.tipTerenaId;
    _selectedPopust = widget.teren.popust ?? 'Ne';
  }

  @override
  void dispose() {
    _nazivController.dispose();
    _brojTerenaController.dispose();
    _cijenaController.dispose();
    _lokacijaController.dispose();
    _cijenaPopustaController.dispose();
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
                                'Naziv Terena',
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
                                  controller: _nazivController,
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
                                'Vrsta Podloge',
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
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  value: _selectedTipTerena,
                                  items: vrstePodloge.map((podloga) {
                                    return DropdownMenuItem<int>(
                                      value: podloga['tipTerenaId'],
                                      child: Text(podloga['naziv']),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTipTerena = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null) {
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
                                'Cijena za teren',
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
                                  controller: _cijenaController,
                                  maxLength: 3,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
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
                                'Broj Terena',
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
                                  controller: _brojTerenaController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
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
                                'Lokacija',
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
                                  controller: _lokacijaController,
                                  decoration: const InputDecoration(
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
                                'Popust',
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
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  value: _selectedPopust,
                                  items: ['Da', 'Ne']
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label),
                                            value: label,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPopust = value;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_selectedPopust == 'Da')
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Unesite vas popust',
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
                                    controller: _cijenaPopustaController,
                                    maxLength: 3,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(8.0),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: (value) {
                                      if (_selectedPopust == 'Da' &&
                                          (value == null || value.isEmpty)) {
                                        return 'Ovo polje je obavezno';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
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
          onPressed: isSaveButtonDisabled
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    widget.handleEdit(
                      widget.teren.terenId!,
                      _nazivController.text,
                      int.tryParse(_cijenaController.text),
                      int.tryParse(_brojTerenaController.text),
                      _selectedTipTerena,
                      _lokacijaController.text,
                      _selectedPopust,
                      int.tryParse(_cijenaPopustaController.text),
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
