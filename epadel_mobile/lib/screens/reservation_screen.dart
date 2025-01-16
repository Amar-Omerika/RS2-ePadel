// ignore_for_file: prefer_const_constructors

import 'package:epadel_mobile/Helpers/eror_dialog.dart';
import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/providers/providers.dart';
import 'package:epadel_mobile/screens/screens.dart';
import 'package:epadel_mobile/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

class ReservationScreen extends StatefulWidget {
  static const routeName = "/reservation";
  final Teren? teren;
  final int? terenId;
  const ReservationScreen({super.key, this.terenId, this.teren});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  int selectedSlot = -1;
  String? potrebnaReketa = 'Ne';
  String? brojReketa = '0';
  int paymentMethod = 1;
  final formKey = GlobalKey<FormState>();
  // Slots logic;
  DateTime selektiraniDatum = DateTime.now().add(Duration(days: 1));
  List<String> _slots = []; // Fetch from backend;
  late AuthProvider _authProvider;
  late RezervacijaProvider _rezervacijaProvider;
  Rezervacija? rezervacija;
  late PlatiTerenProvider _platiTerenProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = context.read<AuthProvider>();
    _rezervacijaProvider = context.read<RezervacijaProvider>();
    fetchSlots();
  }

  void fetchSlots() async {
    var dateString = selektiraniDatum.toString().split(" ")[0];
    print(selektiraniDatum);
    var data = await _rezervacijaProvider.getSlotsByDate(
        {'terenId': widget.terenId, 'datumRezervacije': dateString});
    setState(() {
      _slots = data;
    });
  }

  void handleChange(DateTime date) {
    setState(() {
      selektiraniDatum = date;
    });
    fetchSlots();
  }

  void setSlotIndex(int index) {
    setState(() {
      selectedSlot = index;
    });
  }

  void changeNeedRacket(String? value) {
    setState(() {
      potrebnaReketa = value;
      if (potrebnaReketa == 'Ne') {
        brojReketa = '0';
      }
    });
  }

  void changeNumberOfRackets(String? value) {
    setState(() {
      brojReketa = value ?? '';
    });
  }

  void changePaymentMethod(int value) {
    setState(() {
      paymentMethod = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF618264),
      appBar: AppBar(
        backgroundColor: const Color(0xFF618264),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFFB0D9B1),
          iconSize: 40,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Rezervacija'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Teren Card
              TerenCardWidget(widget: widget),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    color: Colors.green[200],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Datum: ${selektiraniDatum.toLocal().toString().split(' ')[0]}',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.calendar_today, color: Colors.black),
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selektiraniDatum,
                                firstDate: DateTime.now().add(Duration(days: 1)),
                                lastDate: DateTime(2101),
                              );
                              if (pickedDate != null &&
                                  pickedDate != selektiraniDatum) {
                                handleChange(pickedDate);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Available Slots
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      'Slobodni termini',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //time slots logic
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _slots.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setSlotIndex(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: selectedSlot == index
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Center(
                              child: Text(
                                _slots[index],
                                style: TextStyle(
                                  color: selectedSlot == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      'Da li vam je potrebna reketa?',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomDropdownButtonFormField(
                      value: potrebnaReketa,
                      items: const [
                        DropdownMenuItem(value: 'Da', child: Text('Da')),
                        DropdownMenuItem(value: 'Ne', child: Text('Ne')),
                      ],
                      onChanged: changeNeedRacket,
                    ),
                  ),
                  if (potrebnaReketa == 'Da') ...[
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text(
                        'Unesite broj reketa',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CustomTextField(
                        initialValue: brojReketa,
                        keyboardType: TextInputType.number,
                        onChanged: changeNumberOfRackets,
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Nacin placanja',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              changePaymentMethod(1);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: paymentMethod == 1
                                  ? Colors.green[200]
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'online',
                              style: TextStyle(
                                color: paymentMethod == 1
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              changePaymentMethod(2);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: paymentMethod == 2
                                  ? Colors.green[200]
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text(
                              'cash',
                              style: TextStyle(
                                color: paymentMethod == 2
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Cancel and Reserve Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'PONISTI',
                              style: TextStyle(color: Colors.green[200]),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (potrebnaReketa == null ||
                                  potrebnaReketa!.isEmpty) {
                                return showErrorDialog(context,
                                    'Molimo vas da odaberete da li vam je potrebna reketa.');
                              }

                              int brojReketaInt =
                                  int.tryParse(brojReketa!) ?? -1;
                              if (potrebnaReketa == 'Da' &&
                                  (brojReketaInt < 1 || brojReketaInt > 4)) {
                                return showErrorDialog(context,
                                    'Broj reketa mora biti izmedju 1 i 4.');
                              }

                              if (_slots.isEmpty ||
                                  selectedSlot < 0 ||
                                  selectedSlot >= _slots.length) {
                                return showErrorDialog(context,
                                    'Molim vas odaberite slobodan termin.');
                              }
                              var method =
                                  paymentMethod == 1 ? "Online" : "On site";
                              var dateString =
                                  selektiraniDatum.toString().split(" ")[0];
                              if (paymentMethod == 2) {
                                Map<String, dynamic> reservationData = {
                                  'korisnikId': _authProvider.getLoggedUserId(),
                                  'terenId': widget.terenId,
                                  'vrijemeRezervacije': _slots[selectedSlot],
                                  'datumRezervacije': dateString,
                                  'paymentMethod': method,
                                  'cijena': widget.teren!.cijena,
                                  'potrebnaReket': potrebnaReketa,
                                  'brojReketa': brojReketa
                                };
                                print(reservationData);
                                try {
                                  var data = await _rezervacijaProvider!.insert(reservationData);
                                  Navigator.popAndPushNamed(context, ReservationSuccessfulScreen.routeName);
                                } on Exception catch (error) {
                                  print(error.toString());
                                  if (error.toString().contains("Bad request")) {
                                    print('Reservation failed');
                                  }
                                }
                              }
                          
                              if (paymentMethod == 1) {
                                try {
                                Map<String, dynamic> _platiTerenData = {
                                  'korisnikId': _authProvider.getLoggedUserId(),
                                  'terenId': widget.terenId,
                                  'cijena': widget.teren!.cijena,
                                };
                                _platiTerenProvider = PlatiTerenProvider();
                                var data = await _platiTerenProvider.insert(_platiTerenData);
                                    print(data);
                                await Stripe.instance.initPaymentSheet(
                                  paymentSheetParameters: SetupPaymentSheetParameters(
                                    paymentIntentClientSecret: data!.paymentIntentId,
                                    style: ThemeMode.light,
                                    merchantDisplayName: "ePadel",
                                  ),
                                );
                                var result = await Stripe.instance.presentPaymentSheet();
                                         Map<String, dynamic> reservationData = {
                                  'korisnikId': _authProvider.getLoggedUserId(),
                                  'terenId': widget.terenId,
                                  'vrijemeRezervacije': _slots[selectedSlot],
                                  'datumRezervacije': dateString,
                                  'paymentMethod': method,
                                  'cijena': widget.teren!.cijena,
                                  'potrebnaReket': potrebnaReketa,
                                  'brojReketa': brojReketa,
                                  'lokacija': widget.teren!.lokacija,
                                };
                                print(reservationData);
                                try {
                                  var data = await _rezervacijaProvider!.insert(reservationData);
                                  Navigator.popAndPushNamed(context, PaymentSuccessfullScreen.routeName);
                                } on Exception catch (error) {
                                  print(error.toString());
                                  if (error.toString().contains("Bad request")) {
                                    print('Reservation failed');
                                  }
                                }
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'REZERVISI',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TerenCardWidget extends StatelessWidget {
  const TerenCardWidget({
    super.key,
    required this.widget,
  });

  final ReservationScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: imageFromBase64String(
                  widget.teren!.tipTerena!.slika!, 120, 100),
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF618264),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Naziv: ${widget.teren!.naziv}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            'Cijena: ${widget.teren!.cijena} KM',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF618264),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Tip: ${widget.teren!.tipTerena!.naziv}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  const CustomTextField({
    required this.initialValue,
    required this.keyboardType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: TextFormField(
          initialValue: initialValue,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomDropdownButtonFormField extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;

  const CustomDropdownButtonFormField({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          ),
        ),
      ),
    );
  }
}
