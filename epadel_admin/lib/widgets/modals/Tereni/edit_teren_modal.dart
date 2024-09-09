// ignore_for_file: prefer_const_constructors
import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:epadel_admin/providers/gradovi_provider.dart';
import 'package:epadel_admin/models/search_result.dart';

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
  late TextEditingController _cijenaPopustaController;
  late GradoviProvider _gradoviProvider;
  late TipTerenaProvider _tipTerenaProvider;

  SearchResult<Gradovi>? _gradoviResult;
  SearchResult<TipTerena>? resultTipTerena;

  int? _selectedTipTerena;
  int? _selectedGradoviId;
  String? _selectedPopust;

  String? _nazivError;
  String? _brojTerenaError;
  String? _cijenaError;
  String? _tipTerenaError;
  String? _gradoviError;
  String? _cijenaPopustaError;

  @override
  void initState() {
    super.initState();
    _nazivController = TextEditingController(text: widget.teren.naziv);
    _brojTerenaController =
        TextEditingController(text: widget.teren.brojTerena?.toString());
    _cijenaController =
        TextEditingController(text: widget.teren.cijena?.toString());
    _cijenaPopustaController =
        TextEditingController(text: widget.teren.cijenaPopusta?.toString());
    _selectedTipTerena = widget.teren.tipTerenaId;
    _selectedGradoviId = widget.teren.gradovi!.id;
    _selectedPopust = widget.teren.popust ?? 'Ne';
    _initializeData();
  }

  Future<void> _initializeData() async {
    _gradoviProvider = GradoviProvider();
    _tipTerenaProvider = TipTerenaProvider();
    var data = await _gradoviProvider.get();
    var dataTipTerena = await _tipTerenaProvider.get();
    setState(() {
      _gradoviResult = data;
      resultTipTerena = dataTipTerena;
    });
  }

  void _validateForm() {
    setState(() {
      _nazivError =
          _nazivController.text.isEmpty ? 'Ovo polje je obavezno' : null;
      _brojTerenaError =
          _brojTerenaController.text.isEmpty ? 'Ovo polje je obavezno' : null;
      _cijenaError =
          _cijenaController.text.isEmpty ? 'Ovo polje je obavezno' : null;
      _tipTerenaError =
          _selectedTipTerena == null ? 'Ovo polje je obavezno' : null;
      _gradoviError =
          _selectedGradoviId == null ? 'Ovo polje je obavezno' : null;
      if (_selectedPopust == 'Da') {
        int cijena = int.tryParse(_cijenaController.text) ?? 0;
        int cijenaPopusta = int.tryParse(_cijenaPopustaController.text) ?? 0;
        _cijenaPopustaError =
            _cijenaPopustaController.text.isEmpty || cijenaPopusta == 0
                ? 'Ovo polje je obavezno i mora imati vrijednost vecu od 0'
                : (cijenaPopusta > cijena || cijenaPopusta == cijena
                    ? 'Cijena popusta mora biti manja od ukupne cijene'
                    : null);
      }
    });
  }

  @override
  void dispose() {
    _nazivController.dispose();
    _brojTerenaController.dispose();
    _cijenaController.dispose();
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
                              if (_nazivError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _nazivError!,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
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
                                  items: resultTipTerena?.result.map((podloga) {
                                    return DropdownMenuItem<int>(
                                      value: podloga.tipTerenaId,
                                      child: Text(podloga.naziv!),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTipTerena = value;
                                      _tipTerenaError = null;
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
                              if (_tipTerenaError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _tipTerenaError!,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
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
                                    hintText:
                                        "Moguce unijeti samo numericke vrijednosti",
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
                              if (_cijenaError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _cijenaError!,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
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
                                    hintText:
                                        "Moguce unijeti samo numericke vrijednosti",
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
                              if (_brojTerenaError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _brojTerenaError!,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
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
                                'Gradovi',
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
                                  value: _selectedGradoviId,
                                  items: _gradoviResult?.result.map((grad) {
                                    return DropdownMenuItem<int>(
                                      value: grad.id,
                                      child: Text(grad.nazivGrada!),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGradoviId = value;
                                      _gradoviError = null;
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
                              if (_gradoviError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _gradoviError!,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
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
                                      .map((label) => DropdownMenuItem<String>(
                                            child: Text(label),
                                            value: label,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPopust = value;
                                      _cijenaPopustaError = null;
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
                                      hintText:
                                          "Moguce unijeti samo numericke vrijednosti",
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
                                if (_cijenaPopustaError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 4.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _cijenaPopustaError!,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
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
            if (_selectedPopust == 'Ne') {
              _cijenaPopustaController.text = '0';
            }
            if (_nazivError == null &&
                _brojTerenaError == null &&
                _cijenaError == null &&
                _tipTerenaError == null &&
                _gradoviError == null &&
                _cijenaPopustaError == null) {
              widget.handleEdit(
                widget.teren.terenId!,
                _nazivController.text,
                int.tryParse(_cijenaController.text),
                int.tryParse(_brojTerenaController.text),
                _selectedTipTerena,
                _selectedPopust,
                int.tryParse(_cijenaPopustaController.text),
                _selectedGradoviId,
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
