import 'package:flutter/material.dart';
import '../models/teren.dart'; // Adjust the import as per your project structure

class TerenCard extends StatelessWidget {
  final Teren teren;

  const TerenCard({super.key, required this.teren});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(15.0),
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
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                "https://www.shutterstock.com/image-photo/padel-blue-court-white-lines-260nw-2194207723.jpg", // Replace with your image URL
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
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
                  Text('Cijena: ${teren.cijena}'),
                  Text('Lokacija: ${teren.lokacija}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
