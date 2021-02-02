import 'dart:async';
class Validators {
 final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String email, EventSink<String> sink) {
     //A standard email check regex
     Pattern pattern =
       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$';
     RegExp regex = new RegExp(pattern);     if (regex.hasMatch(email))
       sink.add(email);
     else
      sink.addError('Enter a valid email');
    }
);

final validateNik = StreamTransformer<String, String>.fromHandlers(
  handleData: (String number, EventSink<String> sink){
    if(number.length > 1){
      sink.add(number);
    }else{
      sink.addError('username is wrong');
    }
  }
);

final validatePassword = StreamTransformer<String, String>.fromHandlers(
   handleData: (String password, EventSink<String> sink) {
    if (password.length > 1) {
      sink.add(password);
    } else {
     sink.addError('Password must be at least 8 characters long');
    }
   }
 );
}
