import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:epadel_mobile/widgets/teren_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  String _selectedType = 'Svi';
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    _terenProvider = context.read<TerenProvider>();
    loadData();
  }

  Future<void> loadData() async {
    Map<String, String> filters = {'Tekst': _filter, 'Popust': 'Ne'};

    if (_selectedType != 'Svi') {
      filters['TipTerenaTekst'] = _selectedType;
    }

    var tmpData = await _terenProvider.get(filters);
    setState(() {
      _tereni = tmpData as SearchResult<Teren>;
    });
  }

  void _onFilterChanged(String value) {
    setState(() {
      _filter = value;
    });
    loadData();
  }

  void _onTypeSelected(String type) {
    setState(() {
      _selectedType = type;
      _showFilters = false;
    });
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF618264),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: IconButton(
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            _showFilters = !_showFilters;
                          });
                        },
                      ),
                    ),
                  ),        
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TerenInput(
                              filter: _filter,
                              onFilterChanged: _onFilterChanged,
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Expanded(
                    child: _tereni.result.isEmpty &&
                            (_filter.isNotEmpty || _selectedType != 'Svi')
                        ? const Center(
                            child: Text(
                              'Nema rezultata za vasu pretragu...',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
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
            if (_showFilters)
              Positioned(
                top: 120.0,
                left: 90.0,
                right: 90.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children:
                        ['Svi', 'Beton', 'Trava', 'Guma'].map((String type) {
                      return GestureDetector(
                        onTap: () => _onTypeSelected(type),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: type == _selectedType
                                ? Colors.green[600]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Center(
                            child: Text(
                              type,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
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
  const TerenInput({
    super.key,
    required this.filter,
    required this.onFilterChanged,
  });

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
