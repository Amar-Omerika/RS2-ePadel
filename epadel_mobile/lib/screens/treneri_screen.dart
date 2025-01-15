import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';

class TreneriScreen extends StatefulWidget {
  static const String routeName = '/treneri';
  const TreneriScreen({super.key});

  @override
  _TreneriScreenState createState() => _TreneriScreenState();
}

class _TreneriScreenState extends State<TreneriScreen> {
  late TrenerProvider _trenerProvider;
  SearchResult<Trener> _treneri = SearchResult<Trener>();
  final Map<int, bool> _expanded = {};

  @override
  void initState() {
    super.initState();
    _trenerProvider = context.read<TrenerProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var tmpData = await _trenerProvider.get();
    setState(() {
      _treneri = tmpData as SearchResult<Trener>;
      // Initialize the expanded state for each item
      _expanded.clear();
      for (int i = 0; i < _treneri.result.length; i++) {
        _expanded[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treneri'),
        backgroundColor: const Color(0xFF618264),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF618264),
        child: _treneri.result.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _treneri.result.length,
                itemBuilder: (context, index) {
                  if (_treneri.result.isEmpty)
                    return const SizedBox.shrink(); // Guard against empty data
                  final trener = _treneri.result[index];
                  final isExpanded = _expanded[index] ?? false;

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
                          trener.imePrezime ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          isExpanded
                              ? (trener.bio ?? 'N/A')
                              : ((trener.bio?.length ?? 0) > 100
                                  ? '${trener.bio?.substring(0, 100)}...'
                                  : trener.bio ?? 'N/A'),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        if ((trener.bio?.length ?? 0) > 100)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _expanded[index] = !isExpanded;
                              });
                            },
                            child: Text(
                              isExpanded ? 'Show Less' : 'Show More',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Kontakt tel: ${trener.kontaktTel!}',
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
