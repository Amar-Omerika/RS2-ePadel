import 'package:epadel_mobile/utils/util.dart';
import 'package:epadel_mobile/widgets/rating_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:epadel_mobile/models/models.dart';

class RezervacijaCard extends StatelessWidget {
  final Rezervacija rezervacija;

  const RezervacijaCard({super.key, required this.rezervacija});

  void _openRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return RatingDialog(
          terenId: rezervacija.terenId ?? 0,
          onCancel: () {
            // Handle cancel action if needed
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openRatingDialog(context),
      child: Container(
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
                child: imageFromBase64String(rezervacija.teren?.tipTerena?.slika ?? '', 120, 100),
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
                      'Naziv: ${rezervacija.teren?.naziv ?? 'N/A'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Tip: ${rezervacija.teren?.tipTerena?.naziv ?? 'N/A'}'),
                    Text('Lokacija: ${rezervacija.teren?.lokacija ?? 'N/A'}'),
                    Text('Datum Rez: ${rezervacija.datumRezervacije ?? 'N/A'}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
