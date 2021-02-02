import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parkiran/bloc/logoutbloc.dart';
import 'package:parkiran/screens/admin/history/history.dart';
import 'package:parkiran/screens/admin/listkendaraan/listkendaraan.dart';
import 'package:parkiran/screens/admin/scanner/scanner.dart';
// import 'package:parkiran/screens/admin/scanner/scanner.dart';

class HomeScreenAdmin extends StatefulWidget {
  HomeScreenAdmin({Key key}) : super(key: key);

  @override
  _HomeScreenAdminState createState() => _HomeScreenAdminState();
}

class _HomeScreenAdminState extends State<HomeScreenAdmin> {
  // String barcode = "";
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuList = [
      {
        'title': 'Scanner',
        'srcImage': 'assets/icons/scanner.svg',
        'function': () async {
          // Navigator.push(context,
          // MaterialPageRoute(builder: (context) => ScannerScreen()));

          try {
            String barcode = await BarcodeScanner.scan();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScannerScreen(
                          barcode: barcode,
                        )));
            // setState(() {
            //   this.barcode = barcode;
            // });
          } on PlatformException catch (error) {
            if (error.code == BarcodeScanner.CameraAccessDenied) {
              setState(() {
                // this.barcode = 'Izin kamera tidak diizinkan';
              });
            } else {
              setState(() {
                // this.barcode = 'Error: $error';
              });
            }
          }
        }
      },
      {
        'title': 'History',
        'srcImage': 'assets/icons/parking-area.svg',
        'function': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HistoryScreen()));
        },
      },
      {
        'title': 'List Kendaraan',
        'srcImage': 'assets/icons/parking-area2.svg',
        'function': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListKendaraanScreen()));
        }
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Admin"),
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
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    "Yakin ingin Logout?",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
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
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: const Color(0xFFB4C51B),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          logoutBloc.logout();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Keluar",
                                          style: TextStyle(color: Colors.white),
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
      body: Container(
        child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(menuList.length, (index) {
              // print(menuList[index]['title']);
              return InkWell(
                onTap: menuList[index]['function'],
                child: Card(
                  // color: Colors.blue,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          menuList[index]['srcImage'],
                          width: 70,
                        ),
                        Center(
                            child: Text(
                          menuList[index]['title'],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        )),
                      ],
                    ),
                  ),
                ),
              );
            })
            // List.generate(4, (index) {
            //   return Container(
            //     child: Card(
            //       color: Colors.blue
            //     ),
            //   );
            // }),
            ),
      ),
    );
  }
}
