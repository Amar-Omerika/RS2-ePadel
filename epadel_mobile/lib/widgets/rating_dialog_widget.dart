// ignore_for_file: prefer_const_constructors

import 'package:epadel_mobile/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/Helpers/success_dialog.dart';
import 'package:epadel_mobile/Helpers/eror_dialog.dart';

class RatingDialog extends StatefulWidget {
  final int terenId;
  final Function onCancel;

  const RatingDialog({Key? key, required this.terenId, required this.onCancel}) : super(key: key);

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int? _selectedRating;
  final List<int> _ratings = [1, 2, 3, 4, 5];
  String? _errorText;

  void _handleSubmit() async {
    if (_selectedRating == null) {
      setState(() {
        _errorText = 'Morate odabrati ocjenu!';
      });
    } else {
      try {
        final ocjenaProvider = context.read<OcjeneProvider>();
        Ocjene ocjena = Ocjene(ocjena: _selectedRating, terenId: widget.terenId);
        await ocjenaProvider.insert(ocjena);
        Navigator.of(context).pop();  // Close the dialog
        showSuccessDialog(context, "Uspjesno ste dodali ocjenu!");
      } on Exception catch (e) {
        String errorMessage = e.toString().replaceFirst('Exception: ', '');
        showErrorDialog(context, errorMessage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Odaberite Ocjenu',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.green[800],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<int>(
            value: _selectedRating,
            hint: Text('Odaberite ocjenu...'),
            items: _ratings.map((rating) {
              return DropdownMenuItem<int>(
                value: rating,
                child: Text(rating.toString()),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRating = value;
                _errorText = null;
              });
            },
          ),
          if (_errorText != null) 
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(_errorText!, style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onCancel();
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _handleSubmit,
          child: Text('Submit'),
        ),
      ],
    );
  }
}
