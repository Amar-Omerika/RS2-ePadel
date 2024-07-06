import 'dart:io';
import 'package:epadel_admin/Helpers/eror_dialog.dart';
import 'package:epadel_admin/utils/util.dart';
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
    setState(() {
      _selectedYear = '2024';
      _selectedTeren = 'Sve';
      _selectedTerenInt = -1;
      _initializeStatistic();
    });
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
              padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Reporti za terene",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: godine()),
                      const SizedBox(width: 20),
                      Expanded(child: tereni()),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _buildStatisticCard(
                    title: (_selectedTeren == "Sve")
                        ? "Statistika za sve terene u $_selectedYear godini:"
                        : "Statistika za ${_tereni!.result.where((x) => x.terenId.toString() == _selectedTeren).first.naziv} u $_selectedYear godini:",
                    content: [
                      "Broj rezervacija: ${report?.brojRezervacijeTerena}",
                      "Ukupna zarada: ${report?.ukupnaZaradaTerena}KM",
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildStatisticCard(
                    title: "Statistika sistema",
                    content: [
                      "Ukupan broj korisnika aplikacije: ${report?.ukupanBrojKorisnika}",
                      "Ukupna zarada kroz aplikaciju: ${report?.ukupnaZaradaSistema}KM",
                    ],
                  ),
                  const SizedBox(height: 20),
                  pdfButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticCard({required String title, required List<String> content}) {
    return Center(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...content.map((text) => Text(
                text,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              )).toList(),
            ],
          ),
        ),
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
              pw.Text('Statistika sistema',
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
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () async {
            await _pdfGenerator();
                try {
              _reportProvider = ReportProvider();
              Map reportPost = {
                'BrojRezervacijeTerena': report?.brojRezervacijeTerena,
                'UkupnaZaradaTerena': report?.ukupnaZaradaTerena,
                'UkupanBrojKorisnika':
                    report?.ukupanBrojKorisnika,
                'UkupnaZaradaSistema': report?.ukupnaZaradaSistema,
                'KorisnikId': Authorization.korisnikId,
              };
              _reportProvider.insert(reportPost);
            } on Exception catch (e) {
              String errorMessage =
                  e.toString().replaceFirst('Exception: ', '');
              // ignore: use_build_context_synchronously
              showErrorDialog(context, errorMessage);
            }
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Skinite PDF',
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
          width: double.infinity,
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
          width: double.infinity,
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
