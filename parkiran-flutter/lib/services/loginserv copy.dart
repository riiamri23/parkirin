import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parkiran/constants/constants.dart';
import 'package:parkiran/models/Member.dart';

class LoginService {
  Future<String> login(String username, String password) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-Type": "application/x-www-form-urlencoded"
    };

    final Map<String, dynamic> authData = {
      'kd_member': username,
      'password': password,
    };

    var response = await http.post('$baseUrl/login',
        headers: headers,
        body: authData,
        encoding: Encoding.getByName("utf-8"));

    return response.body;
  }

  Future<String> registrasi(Member member, String pathImage) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-Type": "application/x-www-form-urlencoded"
    };
    final Map<String, dynamic> regisData = {
      'kd_member': member.kdMember,
      'password': member.password,
      'kd_kendaraan': member.kdKendaraan,
      'nama_member': member.namaMember,
      'jurusan': member.jurusan,
      'plat_member': member.platMember,
      'create_member': member.createMember
    };


    var response = await http.post(
      '$baseUrl/registrasi',
      headers: headers,
      body: regisData,
      encoding: Encoding.getByName("utf-8"),
    );
    print(response.body);
    print('$baseUrl/registrasi');

    return response.body;
  }
}
