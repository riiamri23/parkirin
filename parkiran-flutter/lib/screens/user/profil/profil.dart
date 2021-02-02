import 'package:flutter/material.dart';
import 'package:parkiran/bloc/authorizationbloc.dart';
import 'package:parkiran/bloc/logoutbloc.dart';
import 'package:parkiran/screens/user/profil/components/body.dart';

class ProfilScreen extends StatefulWidget {
  ProfilScreen({Key key}) : super(key: key);

  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profil Member"),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0)), //this right here
                          child: Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text("Yakin ingin Logout?", style: TextStyle(fontSize: 18),),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RaisedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Batal",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFFB4C51B),
                                        ),
                                        RaisedButton(
                                          onPressed: (){
                                            logoutBloc.logout();
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Keluar",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: const Color(0xFF1BC0C5),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                })
          ],
        ),
        body: Body());
  }
}
