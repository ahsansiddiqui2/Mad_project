import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  String _paymentMethod = 'Easypaisa'; // Default payment method

  Future<void> _makePayment() async {
    if (_formKey.currentState!.validate()) {
      final amount = _amountController.text;
      String url;

      if (_paymentMethod == 'Easypaisa') {
        url =
            'https://api.easypaisa.com/payment'; // Replace with actual Easypaisa API
      } else {
        url = 'https://api.hbl.com/payment'; // Replace with actual HBL API
      }

      try {
        final response = await http.post(Uri.parse(url), body: {
          'amount': amount,
          'mobile_number': _mobileNumberController.text,
          'account_number': _accountNumberController.text,
        });

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          // Handle success response
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Payment Successful',
                  style: TextStyle(color: Colors.green)),
              content: Text('Payment of $amount has been made successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context)
                        .pop(); // Go back to the previous screen
                  },
                  child: Text('OK', style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
          );
        } else {
          // Handle error response
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title:
                  Text('Payment Failed', style: TextStyle(color: Colors.red)),
              content: Text('Please try again.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK', style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        // Handle network error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error', style: TextStyle(color: Colors.red)),
            content: Text('Network error occurred. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK', style: TextStyle(color: Colors.teal)),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Choose Payment Method',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Toggle between Easypaisa and HBL Bank Transfer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _paymentMethod = 'Easypaisa';
                          });
                        },
                        child: Text('Easypaisa',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _paymentMethod == 'Easypaisa'
                              ? Colors.teal
                              : Colors.grey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12), // Adjusted padding
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _paymentMethod = 'HBL';
                          });
                        },
                        child: Text('HBL Bank Transfer',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _paymentMethod == 'HBL'
                              ? Colors.teal
                              : Colors.grey,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12), // Adjusted padding
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      border: OutlineInputBorder(),
                      labelStyle: TextStyle(color: Colors.teal),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  if (_paymentMethod == 'Easypaisa')
                    TextFormField(
                      controller: _mobileNumberController,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.teal),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        return null;
                      },
                    ),
                  if (_paymentMethod == 'HBL')
                    TextFormField(
                      controller: _accountNumberController,
                      decoration: InputDecoration(
                        labelText: 'Account Number',
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.teal),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your account number';
                        }
                        return null;
                      },
                    ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _makePayment,
                    child: Text('Make Payment',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
