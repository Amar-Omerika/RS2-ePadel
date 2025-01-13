// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/feedback_screen.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/obavijesti_screen.dart';
import 'package:epadel_admin/screens/partneri_screen.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:epadel_admin/widgets/modals/Treneri/add_trener_modal.dart';
import 'package:epadel_admin/widgets/modals/Treneri/edit_trener_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrenerScreen extends StatefulWidget {
  static const String routeName = '/treneri';
  const TrenerScreen({Key? key}) : super(key: key);

  @override
  _TrenerScreenState createState() => _TrenerScreenState();
}

class _TrenerScreenState extends State<TrenerScreen> {
  TrenerProvider? _trenerProvider;
  SearchResult<Trener>? result;
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  int _pageSize = 5;

  @override
  void initState() {
    super.initState();
    _trenerProvider = context.read<TrenerProvider>();
    _initializeData();
  }

  Future<void> _initializeData() async {
    Map<String, String> filters = {
      'page': (_currentPage - 1).toString(),
      'pageSize': _pageSize.toString()
    };

    if (_searchController.text.isNotEmpty) {
      filters['Text'] = _searchController.text;
    }

    var data = await _trenerProvider!.get(filters);
    setState(() {
      result = data;
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

  void _nextPage() {
    setState(() {
      _currentPage++;
      _initializeData();
    });
  }

  bool _canGoToNextPage() {
    if (result != null) {
      int totalPages = (result!.totalCount / _pageSize).ceil();
      return _currentPage < totalPages;
    }
    return false;
  }

  void handleAdd(String? imePrezime, String? bio, String? kontaktTel) async {
    await _trenerProvider!.insert({
      'imePrezime': imePrezime,
      'bio': bio,
      'kontaktTel': kontaktTel,
    });
    if (context.mounted) {
      Navigator.pop(context);
      _initializeData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste dodali novog trenera!'),
        ),
      );
    }
  }

  void handleEdit(int id, String imePrezime, String bio, String kontaktTel) async {
    await _trenerProvider!.update(id, {
      'imePrezime': imePrezime,
      'bio': bio,
      'kontaktTel': kontaktTel,
    });
    if (context.mounted) {
      Navigator.pop(context);
      _initializeData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: const Text('Uspješno ste editovali trenera!'),
        ),
      );
    }
  }

  void openAddModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTrenerModal(handleAdd: handleAdd);
      },
    );
  }

  void openEditModal(Trener trener) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTrenerModal(
          id: trener.trenerId!,
          imePrezime: trener.imePrezime!,
          bio: trener.bio!,
          kontaktTel: trener.kontaktTel!,
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
            selectedPage: 'treneri',
            onPageSelected: (page) {
                  if (page == 'treneri') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const TrenerScreen(),
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
                 if (page == 'tereni') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const TereniScreen(),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 120),
                          child: Column(
                            children: [
                              Transform.translate(
                                offset: const Offset(-120, 0),
                                child: const Text(
                                  'Treneri',
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
                                  child: const Text('Dodaj Trenera'),
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
        'Ne postoje podaci sa vašom pretragom. Pokušajte ponovo sa drugim ključnim riječima.',
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
                    'Ime Prezime',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Kontakt Tel',
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
                    'Obriši',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ),
              ),
            ],
            rows: result!.result.map((Trener trener) {
              return DataRow(cells: [
                DataCell(Text(trener.imePrezime!)),
                DataCell(Text(trener.kontaktTel!)),
                DataCell(IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    openEditModal(trener);
                  },
                )),
                DataCell(IconButton(
                  icon: const Icon(Icons.delete, color: Color(0xFFFF9A62)),
                  onPressed: () {
                    openDeleteModal(trener);
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

void openDeleteModal(Trener trener) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Obriši'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Da li ste sigurni da želite da obrišete Trenera?'),
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
                await _trenerProvider!.remove(trener.trenerId!);
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
                          'Ne možete obrisati ovog Trenera!'),
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