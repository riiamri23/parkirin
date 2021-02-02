import 'dart:convert';

import 'package:parkiran/models/HistoryParkir.dart';
import 'package:parkiran/models/ListMasuk.dart';
import 'package:parkiran/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class ParkirBloc {
  Repository repository = Repository();
  final _parkirMasuk = PublishSubject<bool>();
  final _parkirKeluar = PublishSubject<bool>();

  final PublishSubject _historyParkir = PublishSubject<List<HistoryParkir>>();
  Stream<List<HistoryParkir>> get historyParkir => _historyParkir.stream;

  final PublishSubject _listMasuk = PublishSubject<List<ListMasuk>>();
  Stream<List<ListMasuk>> get listMasuk => _listMasuk.stream;

  parkirMasuk({String kdMember}) async {
    // print(kdMember);
    _parkirMasuk.sink.add(true);

    var res = await repository.parkirMasuk(kdMember: kdMember);

    Map<String, dynamic> response = json.decode(res);

    print(response);
  }

  parkirKeluar({String kdMember}) async {
    _parkirKeluar.sink.add(true);

    var res = await repository.parkirKeluar(kdMember: kdMember);

    Map<String, dynamic> response = json.decode(res);

    print(response);
  }

  parkirMasukList() async {
    var res = await repository.parkirList();

    var response = json.decode(res);

    final List<ListMasuk> listMasuk = [];

    response['data'].forEach((data) {
      final ListMasuk masuk = ListMasuk(
          kdMasuk: data['kd_masuk'],
          kdMember: data['kd_member'],
          kdKendaraan: data['kd_kendaraan'],
          platMasuk: data['plat_masuk'],
          tglMasuk: data['tgl_masuk'],
          statusMasuk: data['status_masuk'],
          createMasuk: data['create_masuk'],
          namaKendaraan: data['nama_kendaraan'],
          hargaKendaraan: data['harga_kendaraan'],
          jenisKendaraan: data['jenis_kendaraan'],
          createByKendaraan: data['create_by_kendaraan']);
          listMasuk.add(masuk);
    });

    _listMasuk.sink.add(listMasuk);
  }

  parkirHistory() async {
    var res = await repository.parkirHistory();
    // print(res);
    var response = json.decode(res);
    // print(response['data']);
    final List<HistoryParkir> listHistory = [];
    response['data'].forEach((data) {
      final HistoryParkir history = HistoryParkir(
        kode: data['kode'],
        tanggal: data['tanggal'],
        kdMember: data['kd_member'],
        namaMember: data['nama_member'],
      );
      listHistory.add(history);
    });

    // print(listHistory);
    _historyParkir.sink.add(listHistory);
  }

  dispose() {
    _parkirMasuk.close();
    _parkirKeluar.close();

    _historyParkir.close();
    _listMasuk.close();
  }
}

final parkirBloc = ParkirBloc();
