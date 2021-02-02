import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parkiran/constants/constants.dart';

class ParkirService {
  Future<String> parkirMasuk(String kdMember) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final Map<String, dynamic> member = {
      'member': kdMember,
    };

    var response = await http.post('$baseUrl/parkirmasuk',
        headers: headers, body: member, encoding: Encoding.getByName("utf-8"));

    return response.body;
  }

  Future<String> parkirKeluar(String kdMember) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final Map<String, dynamic> member = {
      'member': kdMember,
    };

    var response = await http.post('$baseUrl/parkirkeluar',
        headers: headers, body: member, encoding: Encoding.getByName("utf-8"));
    print(response.body);

    return response.body;
  }

  Future<String> parkirMasukList() async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-Type": "application/x-www-form-urlencoded"
    };

    var response = await http.get('$baseUrl/parkiranlist', headers: headers);

    return response.body;
  }

  Future<String> parkirHistory() async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-type": "application/x-www-form-urlencoded"
    };

    var response = await http.get('$baseUrl/historyparkir', headers: headers);
    // print(response.statusCode);

    return response.body;
  }
}
