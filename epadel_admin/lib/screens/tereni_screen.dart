import 'package:epadel_admin/screens/appsidebar.dart';
import 'package:epadel_admin/screens/korisnici_screen.dart';
import 'package:epadel_admin/screens/report_screen.dart';
import 'package:epadel_admin/screens/rezervacije_screen.dart';
import 'package:flutter/material.dart';

class TereniScreen extends StatefulWidget {
  static const String routeName = '/tereni';
  const TereniScreen({Key? key}) : super(key: key);

  @override
  _TereniScreenState createState() => _TereniScreenState();
}

class _TereniScreenState extends State<TereniScreen> {
  int _currentPage = 1; // Example pagination state

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
              }
              else if (page == 'rezervacije') {
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
                                    print('Button pressed');
                                  },
                                  child: Text('Dodaj'),
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
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    maxLines: null, // Allow multiline input
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Pretrazi po nazivu terena',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 8.0),
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
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    maxLines: null, // Allow multiline input
                                    keyboardType: TextInputType.multiline,
                                    
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Pretrazi po nazivu terena',
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 8.0),
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
                                ), // Adjust spacing between text field and button
                                ElevatedButton(
                                  onPressed: () {
                                    print('Search Button pressed');
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
                                  child: Row(
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
