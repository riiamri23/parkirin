import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parkiran/constants/constants.dart';

class MemberService{
  Future<String> fetchMember(String kdMember) async{
    // return 'hello';

    
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final Map<String, dynamic> memberData = {
      'kd_member': kdMember,
    };

    var response = await http.post('$baseUrl/getuser', headers: headers, body: memberData, encoding: Encoding.getByName('utf-8'));

    return response.body;
  }
}