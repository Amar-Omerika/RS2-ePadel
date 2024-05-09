import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/tereni_screen.dart';
import 'package:flutter/material.dart';

class KorisniciScreen extends StatefulWidget {
  static const String routeName = '/korisnici';
  const KorisniciScreen({Key? key}) : super(key: key);

  @override
  _KorisniciScreenState createState() => _KorisniciScreenState();
}

class _KorisniciScreenState extends State<KorisniciScreen> {
  int _currentPage = 1; // Example pagination state

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
              }
            },
          ),
          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Pretraži po korisnickom imenu...',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Pretraži po spolu...',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Naziv terena')),
                        DataColumn(label: Text('Vrsta podloge')),
                        DataColumn(label: Text('Uredi')),
                        DataColumn(label: Text('Obriši')),
                      ],
                      rows: List<DataRow>.generate(
                        3,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text('Padel teren ${index + 1}')),
                            DataCell(Text(['beton', 'trava', 'guma'][index])),
                            DataCell(Icon(Icons.edit)),
                            DataCell(Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_left),
                        onPressed: () {
                          // Implement page change
                        },
                      ),
                      Text('$_currentPage'),
                      IconButton(
                        icon: Icon(Icons.arrow_right),
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
}
