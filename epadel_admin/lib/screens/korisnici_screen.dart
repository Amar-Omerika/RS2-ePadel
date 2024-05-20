import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:epadel_admin/widgets/modals/Korisnici/edit_korisnici_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KorisniciScreen extends StatefulWidget {
  static const String routeName = '/korisnici';
  const KorisniciScreen({Key? key}) : super(key: key);

  @override
  _KorisniciScreenState createState() => _KorisniciScreenState();
}

class _KorisniciScreenState extends State<KorisniciScreen> {
  KorisnikProvider? _korisnikProvider;
  List<Korisnik>? _korisnici;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchSpolController = TextEditingController();
  int _currentPage = 1; // Example pagination state

  @override
  void initState() {
    super.initState();
    _korisnikProvider = context.read<KorisnikProvider>();
    loadData();
  }

  void loadData() async {
    Map<String, String> filters = {};

    if (_searchController.text.isNotEmpty) {
      filters['Tekst'] = _searchController.text;
    }
    if (_searchSpolController.text.isNotEmpty) {
      filters['Spol'] = _searchSpolController.text;
    }

    var data = await _korisnikProvider!.get(filters);
    setState(() {
      _korisnici = data;
    });
  }

  void resetSearch() {
    _searchController.text = '';
    _searchSpolController.text = '';
  }

  void handleEdit(int id, String? korisnickoIme, String? email,
      String? dominantnaRuka,
      String? spol) async {
    await _korisnikProvider!.update(id, {
      'korisnickoIme': korisnickoIme,
      'email': email,
      'dominantnaRuka': dominantnaRuka,
      'spol': spol,
    });
    if (context.mounted) {
      Navigator.pop(context);
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste editovali korisnika!'),
        ),
      );
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
                                      hintText: 'Pretrazi po korisnickom imenu',
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
                                  width: 250,
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    controller: _searchSpolController,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Pretrazi po spolu',
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
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    loadData();
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {
                          // Implement page change
                        },
                      ),
                      Text('$_currentPage'),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {
                          // Implement page change
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataListView() {
    if (_korisnici == null || _korisnici!.isEmpty) {
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
              rows: _korisnici!.map((Korisnik korisnik) {
                return DataRow(cells: [
                  DataCell(Text(korisnik.korisnickoIme!)),
                  DataCell(Text(korisnik.dominantnaRuka == null
                      ? 'Nepoznato'
                      : korisnik.dominantnaRuka!)),
                  DataCell(Text(
                      korisnik.spol == null
                      ? 'Nepoznato'
                      : korisnik.spol!)),
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
                    loadData();
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
}
