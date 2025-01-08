import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/feedback_provider.dart';
import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/obavijesti_screen.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:epadel_admin/models/feedback.dart' as feedbacktree;
class FeedbackScreen extends StatefulWidget {
  static const String routeName = '/feedback';
  
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  FeedbackProvider? _feedbackProvider;
  SearchResult<feedbacktree.Feedback>? result;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _searchTipTerenaController =
      TextEditingController();
  int _currentPage = 1;
  int _pageSize = 5;

  @override
  void initState() {
    super.initState();
    _feedbackProvider = context.read<FeedbackProvider>();
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

    var data = await _feedbackProvider!.get(filters);
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'feedback',
            onPageSelected: (page) {
                  if (page == 'feedback') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const FeedbackScreen(),
                  ),
                );
              } 
              else if (page == 'tereni') {
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
              else if (page == 'obavijesti') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const ObavijestiScreen(),
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
                       Align(
                        alignment: Alignment.centerLeft,
                        
                        child: Container(
                          margin: const EdgeInsets.only(left: 120),
                          child: Column(
                            children: [
                              Transform.translate(
                                offset: const Offset(-120, 0),
                                child: const Text(
                                  'Komentari',
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
                      'Komentar',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ),
              ],
              rows: result!.result.map((feedback) {
                return DataRow(cells: [
                  DataCell(Text(feedback.komentar!)),                
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
