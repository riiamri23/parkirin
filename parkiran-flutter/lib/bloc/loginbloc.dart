import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkiran/models/Member.dart';
import 'package:parkiran/services/repository.dart';
import 'package:parkiran/utils/validator.dart';
import 'package:rxdart/rxdart.dart';

import 'authorizationbloc.dart';

class LoginBloc extends Validators {
  Repository repository = Repository();

  final BehaviorSubject _usernameController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final BehaviorSubject _roleController = BehaviorSubject<String>();
  final _login = PublishSubject<bool>();

  final PublishSubject _loginValid = PublishSubject<String>();
  Stream<String> get isLoginValid => _loginValid.stream;

  Stream<String> get usernameStream =>
      _usernameController.stream.transform(validateNik);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  Stream<String> get roleStream =>
      _roleController.stream.transform(validateNik);
  Stream<bool> get loginStream => _login.stream;
  Stream<bool> get submitValid => Rx.combineLatest2(
      usernameStream, passwordStream, (usernameStream, passwordStream) => true);

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRole => _roleController.sink.add;

  void submit() {
    final validUsername = _usernameController.value;
    final validPassword = _passwordController.value;
    final validRole = _roleController.value;

    login(
        validUsername: validUsername,
        validPassword: validPassword,
        validRole: validRole);
  }

  login({String validUsername, String validPassword, String validRole}) async {
    _login.sink.add(true);
    if (validRole == 'admin') {
      if (validUsername != 'admin') {
        Fluttertoast.showToast(
            msg: "Anda Bukan Admin",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    }
    if (validUsername == 'admin' && validPassword == 'admin') {
      authBloc.openSessionAdmin(validUsername);
      return;
    }

    var res = await repository.login(
        username: validUsername, password: validPassword);

    Map<String, dynamic> response = json.decode(res);
    print(response);
    if (response['status'] == 200) {
      Member member = Member.fromJson(response['data'][0]);
      // print(response['data'][0]);
      authBloc.openSession(member);
      return;
    } else {
      Fluttertoast.showToast(
          msg: "username atau password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  dispose() {
    _usernameController.close();
    _passwordController.close();
    _roleController.close();
    _loginValid.close();
    _login.close();
  }
}

final loginBloc = LoginBloc();
