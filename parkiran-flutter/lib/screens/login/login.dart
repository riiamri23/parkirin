import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkiran/bloc/loginbloc.dart';
import 'package:parkiran/screens/registrasi/registrasi.dart';
import 'package:parkiran/bloc/registrasibloc.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _categories = [
      "Mahasiswa",
      "Admin",
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("ParkirinAja"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "ParkirinAja",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff01A0C7)),
                        ),
                      ),
                      SizedBox(height: 45.0),
                      // usernameField,
                      buildInputLogin(context,
                          texthint: "username/nim",
                          bloc: loginBloc.usernameStream,
                          blocChange: loginBloc.changeUsername),
                      SizedBox(height: 25.0),
                      // passwordField,
                      buildInputLogin(context,
                          texthint: "Pasword",
                          bloc: loginBloc.passwordStream,
                          blocChange: loginBloc.changePassword,
                          textObscure: true),
                      SizedBox(height: 25.0),
                      buildSelectInput(context,
                          texthint: "Role", categories: _categories),
                      SizedBox(
                        height: 35.0,
                      ),
                      // loginButon,
                      buildLoginBtn(),
                      SizedBox(
                        height: 15.0,
                      ),
                      buildRegistrasiBtn(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputLogin(BuildContext context,
          {String texthint, bloc, blocChange, bool textObscure = false}) =>
      StreamBuilder(
          stream: bloc,
          builder: (context, snap) {
            return TextFormField(
              obscureText: textObscure,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                hintText: texthint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onChanged: blocChange,
            );
          });

  Widget buildLoginBtn() => StreamBuilder(
      stream: loginBloc.submitValid,
      builder: (context, snap) {
        return Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xff01A0C7),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: (!snap.hasData ? null : loginBloc.submit),
            child: Text("Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                    .copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      });

  Widget buildRegistrasiBtn() => Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => RegistrasiScreen())),
          child: Text("Registrasi",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );

  Widget buildSelectInput(BuildContext context,
          {String texthint, categories}) =>
      StreamBuilder(
        stream: loginBloc.roleStream,
        builder: (context, snapshot) {
          return DropdownButtonFormField(
            items: categories.map<DropdownMenuItem<dynamic>>((String category) {
              return DropdownMenuItem(value: category, child: Text(category));
            }).toList(),
            onChanged: (newValue) {
              // do other stuff with _category
              setState(() {
                loginBloc.changeRole(newValue);
              });
              // state.didChange
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: texthint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          );
        },
      );
}
