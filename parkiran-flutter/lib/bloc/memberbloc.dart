import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';
import 'package:parkiran/models/Member.dart';
import 'package:parkiran/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class MemberBloc {
  final PublishSubject _memberSession = PublishSubject<Member>();
  Stream<Member> get memberSession => _memberSession.stream;

  Repository repository = Repository();

  getMember() async {
    var prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> member = {
      'kd_member': prefs.getString("kdMember"),
      'kd_kendaraan': prefs.getString("kdKendaraan"),
      'nama_member': prefs.getString('namaMember'),
      'jurusan': prefs.getString('jurusan'),
      'plat_member': prefs.getString('platMember'),
      'no_rangka_member': prefs.getString('noRangkaMember'),
      'no_mesin_member': prefs.getString('noMesinMember'),
      'tgl_masuk': prefs.getString('tglMasuk'),
      'status_masuk': prefs.getString('statusMasuk'),
    };

    _memberSession.sink.add(Member.fromJson(member));
  }

  getMemberAdmin({String kdMember}) async {
    var res = await repository.getMember(kdMember: kdMember);

    var response = json.decode(res);
    // print(response['data'][0]);
    Member member;
    if (response['status'] == 200) {
      member = Member(
        kdMember: response['data'][0]['kd_member'],
        kdKendaraan: response['data'][0]['kd_kendaraan'],
        namaMember: response['data'][0]['nama_member'],
        jurusan: response['data'][0]['jurusan'],
        platMember: response['data'][0]['plat_member'],
        noRangkaMember: response['data'][0]['no_rangka_member'],
        noMesinMember: response['data'][0]['no_mesin_member'],
        tglMasuk: response['data'][0]['tgl_masuk'],
        statusMasuk: response['data'][0]['status_masuk'],
      );

      _memberSession.sink.add(member);
      // print(member.kdMember);
    }else if(response['status'] == 401){
      _memberSession.sink.add(member);
    }
    // Member(kdMember: );
  }

  dispose() {
    _memberSession.close();
  }
}

final memberBloc = MemberBloc();
