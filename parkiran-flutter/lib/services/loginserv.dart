import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:parkiran/constants/constants.dart';
import 'package:parkiran/models/Member.dart';
import 'package:path/path.dart';

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
    
    //1. initial variable
    File filePath = File(pathImage);

    var stream = http.ByteStream(filePath.openRead());
    stream.cast();

    var length = await filePath.length();
    
    var uri = Uri.parse('$baseUrl/registrasi');

    //2. create multi request
    var request = http.MultipartRequest("POST", uri);
    
    //3. multipart that takes file
    var multipartFile = http.MultipartFile('fotoprofil', stream, length,
        filename: basename(filePath.path));
        
    //4. add file to multipart
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      "Content-Type": "application/x-www-form-urlencoded"
    };
    
    request.headers.addAll(headers);
    request.files.add(multipartFile);
    request.fields['kd_member'] = member.kdMember;
    request.fields['password'] = member.password;
    request.fields['kd_kendaraan'] = member.kdKendaraan;
    request.fields['nama_member'] = member.namaMember;
    request.fields['jurusan'] = member.jurusan;
    request.fields['plat_member'] = member.platMember;
    request.fields['create_member'] = member.createMember;
    
    // send
    var response = await request.send();
    var respStr = await response.stream.bytesToString();
    print(respStr);
    return respStr;
    // .then((response) {
    //   print(response.statusCode);

    //   // listen for response
    //   response.stream.transform(utf8.decoder).listen((value) {
    //     print(value);
    //   });
    // });
    // return 'success';
  }
}
