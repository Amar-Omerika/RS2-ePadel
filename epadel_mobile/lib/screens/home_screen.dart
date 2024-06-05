import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/models/search_result.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:epadel_mobile/widgets/teren_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TerenProvider _terenProvider;
  SearchResult<Teren> _tereni = SearchResult<Teren>();
  String _filter = '';
  @override
  void initState() {
    super.initState();
    _terenProvider = context.read<TerenProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var tmpData = await _terenProvider.get({'Tekst': _filter});
    setState(() {
      _tereni = tmpData as SearchResult<Teren>;
    });
    print(_tereni.result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TerenInput(
                    filter: _filter,
                    onFilterChanged: (value) {
                      setState(() {
                        _filter = value;
                      });
                      loadData();
                    }),
              ),
            ),
            const SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                itemCount: _tereni.result.length, // Number of items
                itemBuilder: (context, index) {
                  final teren = _tereni.result[index];
                  return TerenCard(
                    teren: teren,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TerenInput extends StatelessWidget {
  final String filter;
  final ValueChanged<String> onFilterChanged;
  const TerenInput(
      {super.key, required this.filter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onFilterChanged,
      decoration: InputDecoration(
        hintText: 'Pretraga po nazivu...',
        suffixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: const BorderSide(color: Colors.black, width: 2.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
      ),
    );
  }
}
