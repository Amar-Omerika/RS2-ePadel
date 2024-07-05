// reservation_successful_screen.dart
import 'package:epadel_mobile/Helpers/eror_dialog.dart';
import 'package:epadel_mobile/Helpers/success_dialog.dart';
import 'package:epadel_mobile/providers/auth_provider.dart';
import 'package:epadel_mobile/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:epadel_mobile/providers/feedback_provider.dart';

class ReservationSuccessfulScreen extends StatefulWidget {
  const ReservationSuccessfulScreen({super.key});
  static const routeName = '/reservation-successful';

  @override
  _ReservationSuccessfulScreenState createState() => _ReservationSuccessfulScreenState();
}

class _ReservationSuccessfulScreenState extends State<ReservationSuccessfulScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  late FeedbackProvider _feedbackProvider;
  late AuthProvider _authProvider;
  String _feedback = '';

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50), // Add space at the top for better visibility
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Rezervacija Uspiješna!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hvala vam na korištenju naše aplikacije. Vaša rezervacija je uspješno završena.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => Navigator.popAndPushNamed(context, NavScreen.routeName),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.green, // Button color
                      backgroundColor: Colors.white, // Text color
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Go to Home',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Ostavite komentar o aplikaciji",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _feedbackController,
                          decoration: const InputDecoration(
                            labelText: 'Unesite vaš feedback',
                            border: OutlineInputBorder(),
                          ),
                          maxLength: 150,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Feedback ne može biti prazan';
                            }
                            if (value.length > 150) {
                              return 'Feedback mora biti ispod 150 karaktera';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _feedback = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              try {
                                _feedbackProvider = FeedbackProvider();
                                _authProvider = AuthProvider();
                                Map feedback = {
                                  'komentar': _feedback,
                                  'korisnikId': _authProvider.getLoggedUserId()
                                };
                                await _feedbackProvider.insert(feedback);
                                _feedbackController.clear();
                                showSuccessDialog(context, "Uspješno ste ostavili komentar!");
                              } on Exception catch (e) {
                                String errorMessage = e.toString().replaceFirst('Exception: ', '');
                                showErrorDialog(context, errorMessage);
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20, 10.0),
                            child: Text('Spasi',
                                style: TextStyle(fontSize: 20, color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50), // Add space at the bottom for better visibility
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
