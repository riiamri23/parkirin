import 'package:flutter/material.dart';
import 'package:parkiran/bloc/parkirBloc.dart';

class ListKendaraanScreen extends StatefulWidget {
  ListKendaraanScreen({Key key}) : super(key: key);

  @override
  _ListKendaraanScreenState createState() => _ListKendaraanScreenState();
}

class _ListKendaraanScreenState extends State<ListKendaraanScreen> {
  @override
  Widget build(BuildContext context) {
    parkirBloc.parkirMasukList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Kendaraan diparkiran'),
      ),
      body: SafeArea(
        child: Container(child: StreamBuilder(stream: parkirBloc.listMasuk, builder: (context, snap) {
          if(snap.connectionState ==ConnectionState.active){
            return ListView.builder(itemCount: snap.data.length, itemBuilder: (context, int i){
              return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      color: Colors.blue, width: 2))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Nama : ${snap.data[i].platMasuk != null ? snap.data[i].platMasuk : 'tidak diketahui'}'),
                              Text('Tanggal : ${snap.data[i].tglMasuk}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('status : ${snap.data[i].kdMasuk}'),
                                  Text('kd Member: ${snap.data[i].kdMember != null ? snap.data[i].kdMember : 'tidak diketahui'}'),
                                ],
                              ),
                            ],
                          ),
                        );
            });
          }else if(snap.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return Center(child: Text('No Data'),);
          }
        },),),
      ),
    );
  }
}
