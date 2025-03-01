import 'package:epadel_admin/providers/auth_provider.dart';
import 'package:epadel_admin/screens/feedback_screen.dart';
import 'package:epadel_admin/screens/login_screen.dart';
import 'package:epadel_admin/screens/obavijesti_screen.dart';
import 'package:epadel_admin/screens/partneri_screen.dart';
import 'package:flutter/material.dart';
import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:epadel_admin/widgets/modals/Korisnici/edit_korisnici_modal.dart';
import 'package:provider/provider.dart';

import 'trener_screen.dart';

class KorisniciScreen extends StatefulWidget {
  static const String routeName = '/korisnici';
  const KorisniciScreen({Key? key}) : super(key: key);

  @override
  _KorisniciScreenState createState() => _KorisniciScreenState();
}

class _KorisniciScreenState extends State<KorisniciScreen> {
  KorisnikProvider? _korisnikProvider;
  AuthProvider? _authProvider;
  SearchResult<Korisnik>? result;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchSpolController = TextEditingController();
  int _currentPage = 1;
  int _pageSize = 5;
  final List<Map<String, dynamic>> spolovi = [
    {'id': 1, 'tipSpola': 'Muško'},
    {'id': 2, 'tipSpola': 'Žensko'}
  ];

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    _authProvider = context.read<AuthProvider>();
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
    if (_searchSpolController.text.isNotEmpty) {
      filters['Spol'] = _searchSpolController.text;
    }

    var data = await _korisnikProvider!.get(filters);
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

  void handleEdit(int id, String? korisnickoIme, String? email,
      String? dominantnaRuka, int? spol, String? slika, bool? aktivan) async {
    print(
        "id: $id, korisnickoIme: $korisnickoIme, email: $email, dominantnaRuka: $dominantnaRuka, spol: $spol");
    try {
      await _korisnikProvider!.update(id, {
        'korisnickoIme': korisnickoIme,
        'email': email,
        'dominantnaRuka': dominantnaRuka,
        'spol': spol,
        'slika': slika,
        'aktivan': aktivan
      });
      if (context.mounted) {
        Navigator.pop(context);
        _initializeData();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: const Text('Uspješno ste editovali korisnika!'),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
                'Nije moguce editovati korisnika jer ima Admin privilegiju!'),
          ),
        );
      }
    }
  }

  void openEditModal(Korisnik korisnik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditKorisnikModal(
          korisnik: korisnik,
          handleEdit: handleEdit,
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
            selectedPage: 'korisnici',
            onPageSelected: (page) {
              if (page == 'korisnici') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const KorisniciScreen(),
                  ),
                );
              } else if (page == 'tereni') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const TereniScreen(),
                  ),
                );
              } else if (page == 'rezervacije') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const RezervacijeScreen(),
                  ),
                );
              } else if (page == 'feedback') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const FeedbackScreen(),
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
              else if (page == 'obavijesti') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const ObavijestiScreen(),
                  ),
                );
              }
                  else if (page == 'partneri') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const PartneriScreen(),
                  ),
                );
              }
               else if (page == 'treneri') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const TrenerScreen(),
                  ),
                );
              }
            },
          ),
          // Main content
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
                                  'Korisnici',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
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
                                    ),
                                  ),
                                  onPressed: () async {
                                    _authProvider?.logout();
                                    Navigator.of(context).pushReplacement(
                                      PageRouteBuilder(
                                        transitionDuration: Duration.zero,
                                        pageBuilder: (_, __, ___) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 10),
                                      child: Center(
                                        child: Text(
                                          'Log out',
                                          style: TextStyle(color: Colors.white),
                                        ),
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
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Pretrazi po korisnickom imenu',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 250,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: DropdownButtonFormField<int>(
                                    value:
                                        null, // Initial value (null means no selection)
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Pretrazi po spolu',
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem<int>(
                                        value: null,
                                        child: Text('Svi'),
                                      ),
                                      ...spolovi
                                          .map((spol) => DropdownMenuItem<int>(
                                                value: spol['id'],
                                                child: Text(spol['tipSpola']),
                                              )),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        if (value != null) {
                                          _searchSpolController.text =
                                              value.toString();
                                        } else {
                                          _searchSpolController.clear();
                                        }
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
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
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.search),
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
          'Ne postoje podaci sa vasom pretragom. Pokusajte ponovo sa drugim kljucnim rijecima.',
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
                      'Korisnicko Ime',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Dominantna ruka',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Spol',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Email',
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
              rows: result!.result.map((Korisnik korisnik) {
                return DataRow(cells: [
                  DataCell(Text(korisnik.korisnickoIme!)),
                  DataCell(Text(korisnik.dominantnaRuka == null
                      ? 'Nepoznato'
                      : korisnik.dominantnaRuka!)),
                  DataCell(Text(korisnik.spolString == null
                      ? 'Nepoznato'
                      : korisnik.spolString!)),
                  DataCell(Text(
                      korisnik.email == null ? 'Nepoznato' : korisnik.email!)),
                  DataCell(IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      openEditModal(korisnik);
                    },
                  )),
                  DataCell(IconButton(
                    icon: const Icon(Icons.delete, color: Color(0xFFFF9A62)),
                    onPressed: () {
                      openDeleteModal(korisnik);
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

  void openDeleteModal(Korisnik korisnik) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Obrisi'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Da li ste sigurni da želite da obrišete Korisnika?'),
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
                  await _korisnikProvider!.remove(korisnik.korisnikId!);
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
                        content: Text(
                            'Ne možete obrisati ovog Korisnika jer ima Admin Privilegiju!'),
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
                shape: BoxShape.circle, color: Colors.green),
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
