
import 'package:http/http.dart' as http;

class AddonService {
  Future<String> checkLinkStatus(String link) async {
    var response = await http.head(link);

    return response.statusCode.toString();
  }
}