import 'dart:io';
import 'package:flutter/material.dart';
import 'package:epadel_admin/models/models.dart';
import 'package:epadel_admin/providers/providers.dart';
import 'package:epadel_admin/providers/report_provider.dart';
import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/feedback_screen.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportScreen extends StatefulWidget {
  static const String routeName = '/report';
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String _selectedYear = '2024';
  String _selectedTeren = 'Sve';
  int _selectedTerenInt = -1;
  final List<String> _years = ['2024', '2025', '2026'];
  late ReportProvider _reportProvider;
  late TerenProvider _terenProvider;
  SearchResult<Teren>? _tereni;
  Report? report;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _initializeStatistic();
  }

  Future<void> _initializeData() async {
    _terenProvider = TerenProvider();
    var data = await _terenProvider.get();
    setState(() {
      _tereni = data;
    });
  }

  Future<void> _initializeStatistic() async {
    _reportProvider = ReportProvider();
    if (_selectedTerenInt == -1) {
      var data = await _reportProvider.getReporti(search: {
        'godina': _selectedYear,
      });
      setState(() {
        report = data;
      });
    } else {
      var data = await _reportProvider.getReporti(
          search: {'godina': _selectedYear, 'terenId': _selectedTerenInt});
      setState(() {
        report = data;
      });
    }
  }

  void resetSearch() {
    _selectedYear = '2024';
    _selectedTeren = 'Sve';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          SidebarNavigation(
            selectedPage: 'report',
            onPageSelected: (page) {
              if (page == 'tereni') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const TereniScreen(),
                  ),
                );
              } else if (page == 'rezervacije') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const RezervacijeScreen(),
                  ),
                );
              } else if (page == 'korisnici') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const KorisniciScreen(),
                  ),
                );
              } else if (page == 'feedback') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const FeedbackScreen(),
                  ),
                );
              } else if (page == 'report') {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    transitionDuration: Duration.zero,
                    pageBuilder: (_, __, ___) => const ReportScreen(),
                  ),
                );
              }
            },
          ),
          // Main content area
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              padding:
                  const EdgeInsets.symmetric(horizontal: 140.0, vertical: 50.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Reporti za terene",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        godine(),
                        tereni(),
                      ],
                    ),
                    const SizedBox(height: 50),
                    Align(
                      alignment: Alignment.topCenter,
                      child: (_selectedTeren == "Sve")
                          ? Text(
                              "Statistika za sve terene u $_selectedYear godini:",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "Statistika za ${_tereni!.result.where((x) => x.terenId.toString() == _selectedTeren).first.naziv} u $_selectedYear godini:",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Broj rezervacija: ${report?.brojRezervacijeTerena}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupna zarada: ${report?.ukupnaZaradaTerena}KM",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ostala statistika",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupan broj korisnika aplikacije: ${report?.ukupanBrojKorisnika}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ukupna zarada kroz aplikaciju: ${report?.ukupnaZaradaSistema}KM",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.normal),
                      ),
                    ),
                    pdfButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pdfGenerator() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              (_selectedTeren == "Sve")
                  ? pw.Text(
                      "Statistika za sve terene u $_selectedYear godini:",
                      style: const pw.TextStyle(fontSize: 20),
                    )
                  : pw.Text(
                      "Statistika za ${_tereni!.result.where((x) => x.terenId.toString() == _selectedTeren).first.naziv} u $_selectedYear godini:",
                      style: const pw.TextStyle(fontSize: 20),
                    ),
              pw.SizedBox(height: 20),
              pw.Text('Broj rezervacija: ${report?.brojRezervacijeTerena}'),
              pw.Text('Ukupna zarada: ${report?.ukupnaZaradaTerena}KM'),
              pw.SizedBox(height: 20),
              pw.Text('Ostala statistika',
                  style: const pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 20),
              pw.Text(
                  'Ukupan broj korisnika aplikacije: ${report?.ukupanBrojKorisnika}'),
              pw.Text(
                  'Ukupna zarada kroz aplikaciju: ${report?.ukupnaZaradaSistema}KM'),
            ],
          );
        },
      ),
    );
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = "${directory.path}/report_$timestamp.pdf";
    final File file = File(path);
    await file.writeAsBytes(await pdf.save());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Izvještaj spremljen na lokaciji $path')),
    );
  }

  Center pdfButton() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF870000),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            await _pdfGenerator();
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Skinite PDF statistike',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Column tereni() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Teren:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonFormField<int>(
            value: _selectedTeren == 'Sve' ? -1 : int.tryParse(_selectedTeren),
            items: [
              const DropdownMenuItem<int>(
                value: -1,
                child: Text('Sve'),
              ),
              if (_tereni != null && _tereni!.result.isNotEmpty)
                ..._tereni!.result.map((teren) {
                  return DropdownMenuItem<int>(
                    value: teren.terenId,
                    child: Text(teren.naziv!),
                  );
                }).toList(),
            ],
            onChanged: (value) {
              setState(() {
                _selectedTerenInt = value!;
                _selectedTeren = value == -1 ? 'Sve' : value.toString();
                _initializeStatistic();
              });
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            validator: (value) {
              if (value == null) {
                return 'Ovo polje je obavezno';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Column godine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Godina:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 40,
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.grey),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedYear,
              items: _years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(year),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedYear = newValue!;
                  _initializeStatistic();
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
