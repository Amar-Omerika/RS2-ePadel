import 'package:epadel_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import '../models/teren.dart'; // Adjust the import as per your project structure

class TerenPopustCard extends StatelessWidget {
  final Teren teren;

  const TerenPopustCard({super.key, required this.teren});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: imageFromBase64String(teren.tipTerena!.slika!, 120, 100),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Naziv: ${teren.naziv}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Tip: ${teren.tipTerena!.naziv}'),
                  Text('Cijena: ${teren.cijena} KM'),
                  Text('Lokacija: ${teren.lokacija}'),
                  Text('Cijena Popusta: ${teren.cijenaPopusta} KM'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}