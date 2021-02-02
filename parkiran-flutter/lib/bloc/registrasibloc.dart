import 'dart:convert';

import 'package:parkiran/models/Member.dart';
import 'package:parkiran/services/repository.dart';
import 'package:parkiran/utils/validator.dart';
import 'package:rxdart/rxdart.dart';

import 'loginbloc.dart';

class RegistrasiBloc extends Validators {
  Repository repository = Repository();
  final _registrasi = PublishSubject<bool>();
  Stream<bool> get registrasiStream => _registrasi.stream;

  final _message = PublishSubject<String>();
  Stream<String> get messageStream => _message.stream;

  void registrasiSubmit(
      {String username,
      String password,
      String jenisKendaraan,
      String nama,
      String fakultas,
      String platMotor, String pathImage}) {
    // print(username);

    var kdJenisKendaraan = '';
    if (jenisKendaraan == 'Motor') {
      kdJenisKendaraan = 'JK001';
    } else if (jenisKendaraan == 'Mobil') {
      kdJenisKendaraan = 'JK002';
    }

    Member member = Member(
        kdMember: username,
        password: password,
        namaMember: nama,
        jurusan: fakultas,
        kdKendaraan: kdJenisKendaraan,
        platMember: platMotor,
        createMember: 'mandiri');
    // print(member.toJson());

    registrasi(member, pathImage);
  }

  registrasi(Member member, String pathImage) async {
    // print(member.kdMember);
    _registrasi.sink.add(true);

    var res = await repository.registrasi(member: member, pathImage: pathImage);
    print(res);

    Map<String, dynamic> response = json.decode(res);

    // print(response);
    if(response['status'] == 200){
      // print(member.kdMember + " " + member.password);
      loginBloc.login(validUsername: member.kdMember, validPassword: member.password);
    }else{
    }
  }


  dispose() {
    _registrasi.close();
    _message.close();
  }
}

final registrasiBloc = RegistrasiBloc();
