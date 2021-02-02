import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:parkiran/bloc/addonbloc.dart';
import 'package:parkiran/bloc/memberbloc.dart';
import 'package:parkiran/constants/constants.dart';
import 'package:parkiran/models/Member.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    memberBloc.getMember();
    var width = MediaQuery.of(context).size.width;
    var cardHight = (width - 48) * (9 / 16);

    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 12),
        // decoration: boxDecoration(bgColor: appStore.scaffoldBackground,showShadow: true, radius: spacing_standard),
        child: StreamBuilder(
          stream: memberBloc.memberSession,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.active) {
              Member member = snap.data;
              String linkImage = "$ipKom/assets/foto/${member.kdMember}.jpg";
              addonBloc.fetchLink(linkImage);
              // print(member.toJson());
              print("$ipKom/assets/foto/${member.kdMember}.jpg");
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          StreamBuilder(
                              stream: addonBloc.linkChecked,
                              builder: (context, snap) {
                                if (snap.connectionState ==
                                    ConnectionState.active) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: t12_primary_color,
                                            width: 2)),
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
                          text(member.namaMember,
                              textColor: textPrimaryColor,
                              fontFamily: fontBold,
                              fontSize: textSizeNormal),
                          text(member.jurusan,
                              textColor: appTextColorSecondary,
                              fontSize: textSizeMedium)
                        ],
                      ),
                      width: double.infinity,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      // decoration: boxDecoration(bgColor: appStore.scaffoldBackground,showShadow: true, radius: spacing_standard),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          text("Informasi Member",
                              textColor: textPrimaryColor,
                              fontFamily: fontBold,
                              fontSize: textSizeLargeMedium),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: cardHight * 2,
                            child: PageView.builder(
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
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
                                            member.tglMasuk != null
                                                ? member.tglMasuk
                                                : '-',
                                            textColor: appTextColorSecondary,
                                            fontFamily: fontMedium),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text("QR-code Member"),
                                            // BarCodeImage(
                                            //   params: Code128BarCodeParams(
                                            //     member.kdMember,
                                            //   ), ),
                                            QrImage(
                                              data: member.kdMember,
                                              version: QrVersions.auto,
                                              size: 250,
                                              gapless: false,
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
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
