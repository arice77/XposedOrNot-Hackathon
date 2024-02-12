import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/digests/keccak.dart';
import 'package:xpose/Models/analytical_breach.dart';

import 'package:hex/hex.dart'; // Import the hex package



class ApiService {
  final String baseUrl = 'https://api.xposedornot.com/v1';
  final String passwordBaseUrl = 'https://passwords.xposedornot.com/v1';
  final String apiKey = 'YOUR_API_KEY'; 

  Future<List<dynamic>?> checkEmailAddressDataBreaches(String email) async {
    final String url = '$baseUrl/check-email/$email';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body)['breaches'][0];
    }
   else if(response.statusCode==404){
    return [];}
    else return null;
    //  else {
    //   throw Exception('Failed to check email address data breaches');
    // }
  }

dataBreachAnalyticsForEmail(String email,BuildContext context) async {
    final String url = '$baseUrl/breach-analytics?email=$email';
    final response = await http.get(Uri.parse(url));

    if ( jsonDecode(response.body)['BreachMetrics']  != null) {
      final analyticaBreach = analyticaBreachFromJson(response.body);
      return analyticaBreach;
    } else {
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No data found '),
        ),
      
      );
      return null;
    }
  }

String keccakHash(String pwd) {
  var keccak = KeccakDigest(512);
  var hash = keccak.process(utf8.encode(pwd));
 return HEX.encode(hash).substring(0, 10); }

 checkPassword(String password) async {
  if (password.isNotEmpty) {
    var pwdHash = keccakHash(password);
    var encodedPwdHash = Uri.encodeComponent(pwdHash);
    var url = Uri.parse('https://passwords.xposedornot.com/api/v1/pass/anon/$encodedPwdHash');
    
    var response = await http.get(url);
    
    if (response.statusCode == 200) {
      return (response.body);
    } else if (response.statusCode == 404) {
      print('Password is safe');
      return null;
    } else {
      print('Error: ${response.statusCode}');
       return null;
    }
  } else {
    print('Oops! Try again with a valid password.');
     return null;
  }
}

  Future<List<Map<String, dynamic>>> getAllDataBreaches() async {
    final String url = '$baseUrl/breaches';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return data['Exposed Breaches'].cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to get all data breaches');
    }
  }

  Future<Map<String, dynamic>> checkDomainBreaches() async {
    final String url = '$baseUrl/domain-breaches/';
    final headers = {'x-api-key': apiKey, 'Content-Length': '0'};

    final response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to check domain breaches');
    }
  }
}


