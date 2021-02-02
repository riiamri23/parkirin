import 'package:parkiran/models/Member.dart';
import 'package:parkiran/services/memberserv.dart';
import 'package:parkiran/services/parkirserv.dart';

import './loginserv.dart';
import './addonserv.dart';

class Repository {
  final loginServ = LoginService();
  final addonServ = AddonService();
  final parkirServ = ParkirService();
  final memberServ = MemberService();

  //login service
  Future<String> login({String username, String password}) =>
      loginServ.login(username, password);
  Future<String> registrasi({Member member, String pathImage}) => loginServ.registrasi(member, pathImage);

  //addon service
  Future<String> checkLink({String link}) => addonServ.checkLinkStatus(link);

  //parkiran service
  Future<String> parkirMasuk({String kdMember}) => parkirServ.parkirMasuk(kdMember);
  Future<String> parkirKeluar({String kdMember}) =>parkirServ.parkirKeluar(kdMember);
  Future<String> parkirList()=> parkirServ.parkirMasukList();
  Future<String> parkirHistory() => parkirServ.parkirHistory();

  //member service
  Future<String> getMember({String kdMember}) => memberServ.fetchMember(kdMember);
}
