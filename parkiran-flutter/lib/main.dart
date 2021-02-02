import 'package:flutter/material.dart';
import 'package:parkiran/bloc/authorizationbloc.dart';
import 'package:parkiran/screens/login/login.dart';
// import 'package:parkiran/screens/user/barcode/barcode.dart';
import 'package:parkiran/screens/user/profil/profil.dart';

import 'screens/admin/home/home.dart';
import 'package:parkiran/bloc/registrasibloc.dart';

// import 'screens/user/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();
    return MaterialApp(
      title: 'Parkiran Member',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: LoginScreen(),
      routes: {
        '/': (context) => StreamBuilder(
              stream: authBloc.isSessionValid,
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data == 'admin') {
                    return HomeScreenAdmin();
                  } else if (snap.data == 'member') {
                    return ProfilScreen();
                  }else{
                    return LoginScreen();
                  }
                } else {
                  return LoginScreen();
                }
              },
            )
      },
      initialRoute: '/',
    );
  }
}
