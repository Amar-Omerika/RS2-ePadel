import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';

class PartneriScreen extends StatefulWidget {
  static const String routeName = '/partneri';
  const PartneriScreen({super.key});

  @override
  _PartneriScreenState createState() => _PartneriScreenState();
}

class _PartneriScreenState extends State<PartneriScreen> {
  late PartneriProvider _partneriProvider;
  SearchResult<Partneri> _partneri = SearchResult<Partneri>();
  final Map<int, bool> _expanded = {};

  @override
  void initState() {
    super.initState();
    _partneriProvider = context.read<PartneriProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var tmpData = await _partneriProvider.get();
    setState(() {
      _partneri = tmpData as SearchResult<Partneri>;
      // Initialize the expanded state for each item
      _expanded.clear();
      for (int i = 0; i < _partneri.result.length; i++) {
        _expanded[i] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partneri'),
        backgroundColor: const Color(0xFF618264),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFF618264),
        child: _partneri.result.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _partneri.result.length,
                itemBuilder: (context, index) {
                  if (_partneri.result.isEmpty)
                    return const SizedBox.shrink(); // Guard against empty data
                  final partneri = _partneri.result[index];
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
                          partneri.naziv ?? 'N/A',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          isExpanded
                              ? (partneri.deskripcija ?? 'N/A')
                              : ((partneri.deskripcija?.length ?? 0) > 100
                                  ? '${partneri.deskripcija?.substring(0, 100)}...'
                                  : partneri.deskripcija ?? 'N/A'),
                          style: const TextStyle(fontSize: 14.0),
                        ),
                        if ((partneri.deskripcija?.length ?? 0) > 100)
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
                            partneri.datumObjave!.substring(0, 10),
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
