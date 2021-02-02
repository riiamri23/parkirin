import 'package:nb_utils/nb_utils.dart';
import 'package:parkiran/models/Member.dart';
import 'package:parkiran/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class AuthorizationBloc {
  final PublishSubject _isSessionValid = PublishSubject<String>();
  Stream<String> get isSessionValid => _isSessionValid.stream;
  Repository repository = Repository();

  void restoreSession() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.get("kdMember") != null) {
      if (prefs.get("kdMember") == 'admin') {
        _isSessionValid.sink.add("admin");
      } else {
        _isSessionValid.sink.add("member");
      }
    }
  }

  void openSession(Member member) async {
    // print(member);
    if (member != null) {
      var prefs = await SharedPreferences.getInstance();

      await prefs.setString("kdMember", member.kdMember);
      await prefs.setString("kdKendaraan", member.kdKendaraan);
      await prefs.setString("namaMember", member.namaMember);
      await prefs.setString("jurusan", member.jurusan);
      await prefs.setString("platMember", member.platMember);
      await prefs.setString("noRangkaMember", member.noRangkaMember);
      await prefs.setString("noMesinMember", member.noMesinMember);
      await prefs.setString("tglMasuk", member.tglMasuk);
      await prefs.setString("statusMasuk", member.statusMasuk);

      _isSessionValid.sink.add("member");
    }
  }

  void openSessionAdmin(String username) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("kdMember", username);
    _isSessionValid.sink.add("admin");
  }

  void closeSession() async {
    var prefs = await SharedPreferences.getInstance();

    if (prefs.get("kdMember") == 'admin') {
      prefs.remove("kdMember");
    } else {
      prefs.remove("kdMember");
      prefs.remove("kdKendaraan");
      prefs.remove("namaMember");
      prefs.remove("jurusan");
      prefs.remove("platMeber");
      prefs.remove("noRangkaMember");
      prefs.remove("noMesinMember");
      prefs.remove("tglMasuk");
      prefs.remove("statusMasuk");
    }
    _isSessionValid.sink.add("");
  }

  disposi() {
    _isSessionValid.close();
  }
}

final authBloc = AuthorizationBloc();
