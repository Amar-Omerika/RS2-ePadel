// ignore_for_file: prefer_const_constructors

import 'package:epadel_admin/models/gradovi.dart';
import 'package:epadel_admin/models/search_result.dart';
import 'package:epadel_admin/models/tip_terena.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTerenModal extends StatefulWidget {
  final Function handleAdd;

  const AddTerenModal({
    super.key,
    required this.handleAdd,
  });

  @override
  State<AddTerenModal> createState() => _AddTerenModalState();
}

class _AddTerenModalState extends State<AddTerenModal> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late GradoviProvider _gradoviProvider;
  late TipTerenaProvider _tipTerenaProvider;

  SearchResult<Gradovi>? result;
  SearchResult<TipTerena>? resultTipTerena;

  String? naziv;
  int? brojTerena;
  int? cijena;
  int? tipTerenaId;
  int? gradoviId;
  String? popust = 'Ne';
  int? cijenaPopusta = 0;

  String? nazivError = null;
  String? brojTerenaError = null;
  String? cijenaError = null;
  String? tipTerenaIdError = null;
  String? gradoviIdError = null;
  String? cijenaPopustaError = null;

  bool get isDodajButtonDisabled {
    if (popust == 'Da' && cijenaPopusta != null && cijena != null) {
      return cijenaPopusta! > cijena!;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _gradoviProvider = GradoviProvider();
    _tipTerenaProvider = TipTerenaProvider();
    var data = await _gradoviProvider.get();
    var dataTipTerena = await _tipTerenaProvider.get();

    setState(() {
      result = data;
      resultTipTerena = dataTipTerena;
    });
  }

  void _validateForm() {
    setState(() {
      nazivError =
          naziv == null || naziv!.isEmpty ? 'Ovo polje je obavezno' : null;
      brojTerenaError = brojTerena == null ? 'Ovo polje je obavezno' : null;
      cijenaError = cijena == null ? 'Ovo polje je obavezno' : null;
      tipTerenaIdError = tipTerenaId == null ? 'Ovo polje je obavezno' : null;
      gradoviIdError = gradoviId == null ? 'Ovo polje je obavezno' : null;
      if (popust == 'Da') {
        cijenaPopustaError = cijenaPopusta == null || cijenaPopusta == 0
            ? 'Ovo polje je obavezno i mora imati vrijednost vecu od 0'
            : null;
      }
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
                                'Naziv Terena',
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
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8.0),
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      naziv = value;
                                      nazivError = null;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (nazivError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                nazivError!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
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
                                child: Column(
                                  children: [
                                    DropdownButtonFormField<int>(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      items: resultTipTerena?.result.map((podloga) {
                                        return DropdownMenuItem<int>(
                                          value: podloga.tipTerenaId,
                                          child: Text(podloga.naziv!),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          tipTerenaId = value;
                                          tipTerenaIdError = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (tipTerenaIdError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      tipTerenaIdError!,
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
                                child: Column(
                                  children: [
                                    TextFormField(
                                      maxLength: 3,
                                      decoration: InputDecoration(
                                        hintText: "Moguce unijeti samo numericke vrijednosti",
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          cijena = int.tryParse(value);
                                          cijenaError = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (cijenaError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      cijenaError!,
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
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Moguce unijeti samo numericke vrijednosti",
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          brojTerena = int.tryParse(value);
                                          brojTerenaError = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (brojTerenaError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      brojTerenaError!,
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
                                child: Column(
                                  children: [
                                    DropdownButtonFormField<int>(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      value: gradoviId,
                                      items: result?.result.map((grad) {
                                        return DropdownMenuItem<int>(
                                          value: grad.id,
                                          child: Text(grad.nazivGrada!),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          gradoviId = value;
                                          gradoviIdError = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (gradoviIdError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      gradoviIdError!,
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
                                child: Column(
                                  children: [
                                    DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                      value: popust,
                                      items: ['Da', 'Ne']
                                          .map((label) =>
                                              DropdownMenuItem<String>(
                                                child: Text(label),
                                                value: label,
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          popust = value;
                                          cijenaPopustaError = null;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (popust == 'Da')
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
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        maxLength: 3,
                                        decoration: InputDecoration(
                                          hintText: "Moguce unijeti samo numericke vrijednosti",
                                          contentPadding: EdgeInsets.all(8.0),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            cijenaPopusta = int.tryParse(value);
                                            cijenaPopustaError = null;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                if (cijenaPopustaError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 4.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        cijenaPopustaError!,
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
          onPressed: isDodajButtonDisabled
              ? null
              : () {
                  _validateForm();
                  if (nazivError == null &&
                      brojTerenaError == null &&
                      cijenaError == null &&
                      tipTerenaIdError == null &&
                      gradoviIdError == null &&
                      cijenaPopustaError == null) {
                    widget.handleAdd(
                      naziv,
                      cijena,
                      brojTerena,
                      tipTerenaId,
                      popust,
                      cijenaPopusta,
                      gradoviId,
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
