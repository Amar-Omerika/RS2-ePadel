import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/widgets/modals/Tereni/add_teren_modal.dart';
import 'package:epadel_admin/widgets/modals/Tereni/edit_teren_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TereniScreen extends StatefulWidget {
  static const String routeName = '/tereni';
  
  const TereniScreen({Key? key}) : super(key: key);

  @override
  _TereniScreenState createState() => _TereniScreenState();
}

class _TereniScreenState extends State<TereniScreen> {
  TerenProvider? _terenProvider;
  SearchResult<Teren>? result;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchTipTerenaController =
      TextEditingController();
  int _currentPage = 1;
  int _pageSize = 5;

  @override
  void initState() {
    super.initState();
    _terenProvider = context.read<TerenProvider>();
    _initializeData();
  }

  Future<void> _initializeData() async {
    Map<String, String> filters = {
      'page': (_currentPage - 1).toString(),
      'pageSize': _pageSize.toString()
    };

    if (_searchController.text.isNotEmpty) {
      filters['Tekst'] = _searchController.text;
    }
    if (_searchTipTerenaController.text.isNotEmpty) {
      filters['TipTerenaTekst'] = _searchTipTerenaController.text;
    }

    var data = await _terenProvider!.get(filters);
    setState(() {
      result = data;
    });
  }

  void _resetPage() {
    setState(() {
      _currentPage = 1;
      _initializeData();
    });
  }

  void _previousPage() {
    setState(() {
      _currentPage--;
      _initializeData();
    });
  }

  bool _canGoToPreviousPage() {
    return _currentPage > 1;
  }

  bool _canGoToNextPage() {
    if (result != null) {
      int totalPages = (result!.totalCount / _pageSize).ceil();
      return _currentPage < totalPages;
    }
    return false;
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
      _initializeData();
    });
  }

  void resetSearch() {
    _searchController.text = '';
    _searchTipTerenaController.text = '';
  }

  void handleAdd(String? naziv, int? cijena, int? brojTerena, int? tipTerenaId, 
      String? lokacija, String? popust, int? cijenaPopusta) async {
    await _terenProvider!.insert({
      'naziv': naziv,
      'cijena': cijena,
      'brojTerena': brojTerena,
      'tipTerenaId': tipTerenaId,
      'lokacija': lokacija,
      'popust': popust,
      'cijenaPopusta': cijenaPopusta
    });
    if (context.mounted) {
      Navigator.pop(context);
      resetSearch();
      _initializeData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste dodali novi teren!'),
        ),
      );
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTerenModal(handleAdd: handleAdd);
      },
    );
  }

  void handleEdit(
      int id,
      String? naziv,
      int? cijena,
      int? brojTerena,
      int? tipTerenaId,
      String? lokacija,
      String? popust,
      int? cijenaPopusta) async {
    await _terenProvider!.update(id, {
      'naziv': naziv,
      'cijena': cijena,
      'brojTerena': brojTerena,
      'tipTerenaId': tipTerenaId,
      'lokacija': lokacija,
      'popust': popust,
      'cijenaPopusta': cijenaPopusta
    });
    if (context.mounted) {
      Navigator.pop(context);
      _initializeData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste editovali Teren!'),
        ),
      );
    }
  }

  void openEditModal(Teren teren) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTerenModal(
          teren: teren,
          handleEdit: handleEdit,
        );
      },
    );
  }

  void openDeleteModal(Teren teren) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Obrisi'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete Teren?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Poništi'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _terenProvider!.remove(teren.terenId!);
                  if (context.mounted) {
                    Navigator.pop(context);
                    _initializeData();
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Ne možete obrisati ovaj Teren!'),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Obriši',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'tereni',
            onPageSelected: (page) {
              if (page == 'tereni') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const TereniScreen(),
                  ),
                );
              } else if (page == 'korisnici') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const KorisniciScreen(),
                  ),
                );
              } else if (page == 'rezervacije') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const RezervacijeScreen(),
                  ),
                );
              } else if (page == 'report') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const ReportScreen(),
                  ),
                );
              }
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            children: [
                              Transform.translate(
                                offset: const Offset(-120, 0),
                                child: const Text(
                                  'Tereni',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Transform.translate(
                                offset: const Offset(-35, 0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    openAddModal();
                                  },
                                  child: const Text('Dodaj Teren'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    minimumSize:
                                        MaterialStateProperty.all<Size>(
                                            const Size(150, 40)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 250, // Set the desired width
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    controller: _searchController,
                                    maxLines: null, // Allow multiline input
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Pretrazi po nazivu terena',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250, // Set the desired width
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    controller: _searchTipTerenaController,
                                    maxLines: null, // Allow multiline input
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Pretrazi po vrsti podloge',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _resetPage();
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              const Size(10, 45)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                      )),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons
                                          .search), // Add the search icon here
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDataListView(),
                  _buildPaginationControls(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    if (result == null || result!.result.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Ne postoje podadci sa vasom pretragom. Pokusajte ponovo sa drugim kljucnim rijecima.',
          style: TextStyle(
              fontSize: 18, color: Color.fromARGB(255, 119, 119, 119)),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: const Color(0xFFD7D2DC),
          width: 1.0,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: double.infinity, // Expand to maximum width
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DataTable(
              border: const TableBorder(
                horizontalInside: BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
              ),
              headingRowColor: MaterialStateProperty.all<Color?>(
                Colors.green,
              ),
              columns: const [
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Naziv terena',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Vrsta podloge',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Uredi',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Obrisi',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ],
              rows: result!.result.map((Teren teren) {
                return DataRow(cells: [
                  DataCell(Text(teren.naziv!)),
                  DataCell(Text(teren.tipTerena!.naziv!)),
                  DataCell(IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      openEditModal(teren);
                    },
                  )),
                  DataCell(IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFFF9A62)),
                    onPressed: () {
                      openDeleteModal(teren);
                    },
                  )),
                ]);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaginationControls() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: _canGoToPreviousPage() ? _previousPage : null,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: Text(
              '$_currentPage',
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: _canGoToNextPage() ? _nextPage : null,
          ),
        ],
      ),
    );
  }
}
