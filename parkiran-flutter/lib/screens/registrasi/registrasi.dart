import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parkiran/bloc/loginbloc.dart';
import 'package:parkiran/bloc/registrasibloc.dart';

class RegistrasiScreen extends StatefulWidget {
  RegistrasiScreen({Key key}) : super(key: key);

  @override
  _RegistrasiScreenState createState() => _RegistrasiScreenState();
}

class _RegistrasiScreenState extends State<RegistrasiScreen> {
  String _path;

  final _usernameFormController = TextEditingController();
  final _passwordFormController = TextEditingController();
  final _jenisKendaraanFormController = TextEditingController();
  final _namaFormController = TextEditingController();
  final _fakultasFormController = TextEditingController();
  final _platmotorFormController = TextEditingController();
  // final _currentSelectedValue = TextEditingController();
  String jenisKendaraanSelect, fakultasSelect;

  @override
  Widget build(BuildContext context) {
    var _categories = [
      "Fakultas Teknik",
      "Fakultas Pendidikan",
      "Fakultas Psikologi",
      "Fakultas Ilmu Bahasa"
    ];

    var _jenisKendaraan = ['Motor', 'Mobil'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Registrasi ParkirinAja"),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: SingleChildScrollView(
                child: Form(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          _showPhotoLibrary();
                        },
                        child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                _path != null ? Image.asset(_path).image : null,
                            // backgroundImage: Colors.grey,
                            child: Icon(Icons.camera_alt),
                            radius: 60),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      buildInputLogin(context,
                          texthint: "Username/nim",
                          formController: _usernameFormController),
                      SizedBox(
                        height: 15.0,
                      ),
                      buildInputLogin(context,
                          texthint: "Password",
                          formController: _passwordFormController,
                          textObscure: true),
                      SizedBox(
                        height: 15.0,
                      ),
                      buildInputLogin(context,
                          texthint: "Nama",
                          formController: _namaFormController),
                      SizedBox(
                        height: 15.0,
                      ),
                      // buildInputLogin(context,
                      //     texthint: "Jenis Kendaraan",
                      //     formController: _jenisKendaraanFormController,
                      //     bloc: loginBloc.usernameStream,
                      //     blocChange: loginBloc.changeUsername),
                      buildSelectInput(context,
                          texthint: "Jenis Kendaraan",
                          formController: jenisKendaraanSelect,
                          categories: _jenisKendaraan),
                      SizedBox(
                        height: 15.0,
                      ),
                      // buildInputLogin(context,
                      //     texthint: "Fakultas",
                      //     formController: _fakultasFormController,
                      //     bloc: loginBloc.usernameStream,
                      //     blocChange: loginBloc.changeUsername),
                      buildSelectInput(context,
                          texthint: "Fakultas",
                          formController: fakultasSelect,
                          categories: _categories),
                      SizedBox(
                        height: 15.0,
                      ),
                      buildInputLogin(context,
                          texthint: "Plat Motor",
                          formController: _platmotorFormController),
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
          {String texthint, formController, bool textObscure = false}) =>
      TextFormField(
        controller: formController,
        obscureText: textObscure,
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: texthint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      );
  // });

  Widget buildSelectInput(BuildContext context,
          {String texthint, formController, categories}) =>
      DropdownButtonFormField(
        items: categories.map<DropdownMenuItem<dynamic>>((String category) {
          return DropdownMenuItem(value: category, child: Text(category));
        }).toList(),
        onChanged: (newValue) {
          // do other stuff with _category
          setState(() {
            formController = newValue;
            if (texthint == 'Fakultas') {
              fakultasSelect = newValue;
            }

            if (texthint == 'Jenis Kendaraan') {
              jenisKendaraanSelect = newValue;
            }
          });
          // state.didChange
        },
        value: formController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: texthint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
      );

  Widget buildRegistrasiBtn() => Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            // print(jenisKendaraanSelect);
            if (_usernameFormController.value.text != null &&
                _passwordFormController.value.text != null &&
                jenisKendaraanSelect != null &&
                _namaFormController.value.text != null &&
                fakultasSelect != null &&
                _platmotorFormController.value.text != null &&
                _path != null) {
              registrasiBloc.registrasiSubmit(
                  username: _usernameFormController.value.text,
                  password: _passwordFormController.value.text,
                  // jenisKendaraan: _jenisKendaraanFormController.value.text,
                  jenisKendaraan: jenisKendaraanSelect,
                  nama: _namaFormController.value.text,
                  // fakultas: _fakultasFormController.value.text,
                  fakultas: fakultasSelect,
                  platMotor: _platmotorFormController.value.text,
                  pathImage: _path);
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(
                  msg: 'Isi semua inputan', toastLength: Toast.LENGTH_SHORT);
            }
          },
          child: Text("Registrasi",
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0)
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      );

  void _showPhotoLibrary() async {
    final picker = ImagePicker();

    await picker.getImage(source: ImageSource.gallery).then((value) async {
      setState(() {
        _path = value.path;
      });
    });
  }
}
