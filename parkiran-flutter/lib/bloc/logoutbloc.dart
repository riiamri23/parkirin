
import 'authorizationbloc.dart';

class LogoutBloc {
  
  logout(){
    authBloc.closeSession();
  }
}


final logoutBloc = LogoutBloc();