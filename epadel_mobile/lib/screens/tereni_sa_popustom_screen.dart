import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:epadel_mobile/widgets/teren_popust_widget.dart';
class TereniSaPopustom extends StatefulWidget {
  const TereniSaPopustom({super.key});

  @override
  State<TereniSaPopustom> createState() => _TereniSaPopustomState();
}

class _TereniSaPopustomState extends State<TereniSaPopustom> {
  late TerenProvider _terenProvider;
  SearchResult<Teren> _tereni = SearchResult<Teren>();

  @override
  void initState() {
    super.initState();
    _terenProvider = context.read<TerenProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var tmpData = await _terenProvider.get({'Popust': 'Da'});
    setState(() {
      _tereni = tmpData as SearchResult<Teren>;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text('Aktuelne ponude',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              const SizedBox(height: 5.0),
              Expanded(
                child: _tereni.result.isEmpty
                    ? const Center(
                        child: Text(
                          'Nema dostupnih terena sa popustom...',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _tereni.result.length,
                        itemBuilder: (context, index) {
                          final teren = _tereni.result[index];
                          return TerenPopustCard(
                            teren: teren,
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
