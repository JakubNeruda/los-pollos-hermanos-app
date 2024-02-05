import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class TermsConditionsPage extends StatefulWidget {
  @override
  _TermsConditionsPageState createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> _fetchTermsAndConditions() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('utils').doc('documents').get();

      String termsUrl = (documentSnapshot.data()
              as Map<String, dynamic>)['termsAndConditions'] ??
          '';

      if (termsUrl.isEmpty) {
        return 'No Terms and Conditions URL found.';
      }

      // Use the URL to fetch the actual document from Firebase Storage
      final response = await http.get(Uri.parse(termsUrl));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Failed to load Terms and Conditions document.';
      }
    } catch (e) {
      return 'Error fetching terms and conditions: ${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: FutureBuilder<String>(
        future: _fetchTermsAndConditions(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(snapshot.data ?? ''),
            );
          }
        },
      ),
    );
  }
}
