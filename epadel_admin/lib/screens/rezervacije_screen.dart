// ignore_for_file: prefer_const_constructors

import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/rezervacije_provider.dart';
import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RezervacijeScreen extends StatefulWidget {
  static const String routeName = '/rezervacije';
  const RezervacijeScreen({Key? key}) : super(key: key);

  @override
  _RezervacijeScreenState createState() => _RezervacijeScreenState();
}

class _RezervacijeScreenState extends State<RezervacijeScreen> {
  RezervacijaProvider? _rezervacijeProvider;
  SearchResult<Rezervacija>? result;
  int _currentPage = 1;
  int _pageSize = 5;
  String _selectedFilter = 'Svi';

  @override
  void initState() {
    super.initState();
    _rezervacijeProvider = context.read<RezervacijaProvider>();
    _initializeData();
  }

  Future<void> _initializeData() async {
    Map<String, String> filters = {
      'page': (_currentPage - 1).toString(),
      'pageSize': _pageSize.toString(),
      'filter': _selectedFilter,
    };

    var data = await _rezervacijeProvider!.get(filters);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'rezervacije',
            onPageSelected: (page) {
              if (page == 'rezervacije') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const RezervacijeScreen(),
                  ),
                );
              } else if (page == 'korisnici') {
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
                      Text(
                        'Pregled rezervacija',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7D2DC),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Ukupan broj rezervacija',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    width: 300,
                                    height: 100,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        result?.totalCount.toString() ?? '0',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Broj iznajmljenih reketa',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    width: 300,
                                    height: 100,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        result?.ukupanBrojReketa.toString() ??
                                            '0', // Replace with actual data
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.filter_list),
                          onSelected: (String result) {
                            setState(() {
                              _selectedFilter = result;
                              _resetPage(); // Reset page after setting the filter
                            });
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'Svi',
                              child: Text('Svi'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Padel teren 1',
                              child: Text('Padel teren 1'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Padel teren 2',
                              child: Text('Padel teren 2'),
                            ),
                            const PopupMenuItem<String>(
                              value: 'Padel teren 3',
                              child: Text('Padel teren 3'),
                            ),
                          ],
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
                      'Ime terena',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Korisnik',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: Text(
                      'Cijena(KM)',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ],
              rows: result!.result.map((Rezervacija rezervacija) {
                return DataRow(cells: [
                  DataCell(Text(rezervacija.terenNaziv ?? 'Nepoznato')),
                  DataCell(Text(rezervacija.korisnickoIme ?? 'Nepoznato')),
                  DataCell(Text(rezervacija.cijena?.toString() ?? 'Nepoznato'))
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
