import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:epadel_mobile/models/obavijesti.dart';

class ObavijestiScreen extends StatefulWidget {
  static const String routeName = '/obavijesti';
  const ObavijestiScreen({super.key});

  @override
  _ObavijestiScreenState createState() => _ObavijestiScreenState();
}

class _ObavijestiScreenState extends State<ObavijestiScreen> {
  late ObavijestiProvider _obavijestiProvider;
  SearchResult<Obavijesti> _obavijesti = SearchResult<Obavijesti>();

  @override
  void initState() {
    super.initState();
    _obavijestiProvider = context.read<ObavijestiProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var tmpData = await _obavijestiProvider.get();
    setState(() {
      _obavijesti = tmpData as SearchResult<Obavijesti>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Obavijesti'),
        backgroundColor: const Color(0xFF618264),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF618264),
        child: _obavijesti.result.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _obavijesti.result.length,
                itemBuilder: (context, index) {
                  final obavijest = _obavijesti.result[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          obavijest.naslov ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          obavijest.sadrzaj ?? 'N/A',
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            obavijest.datumObjave ?? 'N/A',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
