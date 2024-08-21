import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:epadel_mobile/widgets/rezervacija_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryReservationScreen extends StatefulWidget {
  static const routeName = "/history-reservation";
  const HistoryReservationScreen({super.key});

  @override
  State<HistoryReservationScreen> createState() =>
      _HistoryReservationScreenState();
}

class _HistoryReservationScreenState extends State<HistoryReservationScreen> {
  late RezervacijaProvider _rezervacijaProvider;
  AuthProvider? _authProvider;
  SearchResult<Rezervacija>? _rezervacije;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var data = await _rezervacijaProvider
        .getHistory(search: {'korisnikId': _authProvider!.getLoggedUserId()});
    setState(() {
      _rezervacije = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF618264),
      appBar: AppBar(
        backgroundColor: const Color(0xFF618264),
        foregroundColor:  Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFFB0D9B1),
          iconSize: 40,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Historija Rezervacija'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5.0),
              Expanded(
                child: _rezervacije == null
                    ? const Center(child: CircularProgressIndicator())
                    : _rezervacije!.result.isEmpty
                        ? const Center(
                            child: Text(
                              'Nema dostupnih rezervacija...',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _rezervacije!.result.length,
                            itemBuilder: (context, index) {
                              final rezervacija = _rezervacije!.result[index];
                              return RezervacijaCard(
                                rezervacija: rezervacija,
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
