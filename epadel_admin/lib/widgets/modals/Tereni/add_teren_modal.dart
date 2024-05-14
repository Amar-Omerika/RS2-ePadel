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
  String? naziv;
  int? brojTerena;
  int? cijena;
  int? tipTerenaId;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Dodaj Teren'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Naziv Terena',
              ),
              onChanged: (value) {
                naziv = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Broj Terena',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                brojTerena = int.tryParse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              maxLength: 3,
              decoration: const InputDecoration(
                labelText: 'Cijena',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                cijena = int.tryParse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
            TextFormField(
              maxLength: 3,
              decoration: const InputDecoration(
                labelText: 'Tip Terena',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (value) {
                tipTerenaId = int.tryParse(value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ovo polje je obavezno';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Poništi'),
        ),
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              widget.handleAdd(naziv!, cijena!, brojTerena!, tipTerenaId!);
            }
          },
          child: const Text('Dodaj'),
        ),
      ],
    );
  }
}
