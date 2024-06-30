import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:epadel_mobile/widgets/teren_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RecommendScreen extends StatefulWidget {
  static const String routeName = '/recommend';
  const RecommendScreen({super.key});

  @override
  _RecommendScreenState createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  late TerenProvider _terenProvider;
  List<Teren> _tereni = [];

  @override
  void initState() {
    super.initState();
    _terenProvider = context.read<TerenProvider>();
    loadData();
  }

  Future<void> loadData() async {
    var tmpData = await _terenProvider.getTereniSaPopustom();
    setState(() {
      _tereni = tmpData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF618264),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFFB0D9B1),
          iconSize: 40,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: const Color(0xFF618264),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text('Preporuceni tereni',
                        style: TextStyle(color: Colors.white, fontSize: 24)),
                  ),
                  const SizedBox(height: 5.0),
                  Expanded(
                    child: _tereni.isEmpty
                        ? const Center(
                            child: Text(
                              'Nema rezultata za vasu pretragu...',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _tereni.length, // Number of items
                            itemBuilder: (context, index) {
                              final teren = _tereni[index];
                              return TerenCard(
                                teren: teren,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
