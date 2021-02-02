

import 'package:parkiran/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class AddonBloc{
  Repository repository = Repository();

  final PublishSubject _linkChecked = PublishSubject<String>();
  Stream<String> get linkChecked => _linkChecked.stream;

  dispose(){
    _linkChecked.close();
  }

  fetchLink(String link) async {
    var result = await repository.checkLink(link: link);

    _linkChecked.sink.add(result);
  }

}
final addonBloc = AddonBloc();