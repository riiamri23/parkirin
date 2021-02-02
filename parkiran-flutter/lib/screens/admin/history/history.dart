import 'package:flutter/material.dart';
import 'package:parkiran/bloc/parkirBloc.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    parkirBloc.parkirHistory();
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: parkirBloc.historyParkir,
              builder: (context, snap) {
                print(snap.data);
                // Widget listData;
                if (snap.connectionState == ConnectionState.active) {
                  return Container(
                    child: ListView.builder(
                      itemCount: snap.data.length,
                      itemBuilder: (context, int index) {
                        // return Text(snap.data[index].kode);

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
                              Text('Nama : ${snap.data[index].namaMember != null ? snap.data[index].namaMember : 'tidak diketahui'}'),
                              Text('Tanggal : ${snap.data[index].tanggal}'),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('status : ${snap.data[index].kode}'),
                                  Text('kd Member: ${snap.data[index].kdMember != null ? snap.data[index].kdMember : 'tidak diketahui'}'),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else if (snap.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Text('no data'),
                  );
                }
              }),
          // child: ListView(
          //   children: [

          //   ],
          // ),
        ),
      ),
    );
  }
}
