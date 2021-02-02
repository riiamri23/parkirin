import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:parkiran/bloc/addonbloc.dart';
import 'package:parkiran/bloc/memberbloc.dart';
import 'package:parkiran/bloc/parkirBloc.dart';
import 'package:parkiran/constants/constants.dart';
import 'package:parkiran/models/Member.dart';

class ScannerScreen extends StatefulWidget {
  // final String barcode = '1603040004';
  final String barcode;

  ScannerScreen({this.barcode});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  int _radioValue1 = -1;
  int correctScore = 0;
  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    memberBloc.getMemberAdmin(kdMember: widget.barcode);
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Code'),
      ),
      body: Center(
          child: StreamBuilder(
        stream: memberBloc.memberSession,
        builder: (context, snapshot) {
          Widget widgetBuilder = Container();
          // print(snapshot.hasData);
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              Member member = snapshot.data;
              String linkImage = "$ipKom/assets/foto/${member.kdMember}.jpg";
              addonBloc.fetchLink(linkImage);
              widgetBuilder = Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder(
                        stream: addonBloc.linkChecked,
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.active) {
                            return Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: t12_primary_color, width: 2)),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      Image.network(linkImage).image,
                                  // AssetImage("assets/images/user.png"),
                                  radius: 45),
                            );
                          }
                          return Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: t12_primary_color, width: 2)),
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage("assets/images/user.png"),
                                radius: 45),
                          );
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        text("Kode Member",
                            textColor: textPrimaryColor,
                            fontSize: textSizeMedium),
                        text(member.kdMember,
                            textColor: appTextColorSecondary,
                            fontFamily: fontMedium),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        text("Kendaraan",
                            textColor: textPrimaryColor,
                            fontSize: textSizeMedium),
                        text(member.kdKendaraan,
                            textColor: appTextColorSecondary,
                            fontFamily: fontMedium),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        text("Plat Kendaraan",
                            textColor: textPrimaryColor,
                            fontSize: textSizeMedium),
                        text(member.platMember,
                            textColor: appTextColorSecondary,
                            fontFamily: fontMedium),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Flexible(
                      child: Container(
                        child: text(
                            member.statusMasuk != null
                                ? member.statusMasuk == '1'
                                    ? "Berada dalam area parkir"
                                    : " Terakhir memasuki parkiran"
                                : "Belum memasuki parkiran",
                            textColor: appTextColorSecondary,
                            fontFamily: fontMedium),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: text(
                            member.tglMasuk != null ? member.tglMasuk : '-',
                            textColor: appTextColorSecondary,
                            fontFamily: fontMedium),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        member.statusMasuk == '2'
                            ? Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 0,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                    ),
                                    Text(
                                      'Kendaraan Masuk',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _radioValue1,
                                      onChanged: _handleRadioValueChange1,
                                    ),
                                    Text(
                                      'Kendaraan Keluar',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xff01A0C7),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width / 2,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                          if (_radioValue1 == 0) {
                            await parkirBloc.parkirMasuk(
                                kdMember: widget.barcode);

                            Fluttertoast.showToast(
                                msg: 'Memasuki Parkiran',
                                toastLength: Toast.LENGTH_SHORT);
                            Navigator.pop(context);
                          } else if (_radioValue1 == 1) {
                            await parkirBloc.parkirKeluar(
                                kdMember: widget.barcode);

                            Fluttertoast.showToast(
                                msg: 'Keluar Parkiran',
                                toastLength: Toast.LENGTH_SHORT);
                            Navigator.pop(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Belum Memilih',
                                toastLength: Toast.LENGTH_SHORT);
                          }
                        },
                        child: Text("Submit",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                    fontFamily: 'Montserrat', fontSize: 20.0)
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Member Tidak ditemukan'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            widgetBuilder = Center(
              child: CircularProgressIndicator(),
            );
          }
          return widgetBuilder;
        },
      )),
    );
  }

  Widget text(
    String text, {
    var fontSize = textSizeLargeMedium,
    textColor = appTextColorSecondary,
    var fontFamily,
    var isCentered = false,
    var maxLine = 1,
    var latterSpacing = 0.5,
    bool textAllCaps = false,
    var isLongText = false,
    bool lineThrough = false,
  }) {
    return Text(
      textAllCaps ? text.toUpperCase() : text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: isLongText ? null : maxLine,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily ?? null,
        fontSize: fontSize,
        color: textColor,
        height: 1.5,
        letterSpacing: latterSpacing,
        decoration:
            lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
