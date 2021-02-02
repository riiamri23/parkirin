import 'package:flutter/material.dart';

class Member {
  String kdMember;
  String password;
  String kdKendaraan;
  String jurusan;
  Null kdKartu;
  String namaMember;
  String platMember;
  String noRangkaMember;
  String noMesinMember;
  String createMember;
  String tglMasuk;
  String statusMasuk;

  Member(
      {@required this.kdMember,
      this.password,
      this.kdKendaraan,
      this.jurusan,
      this.kdKartu,
      this.namaMember,
      this.platMember,
      this.noRangkaMember,
      this.noMesinMember,
      this.createMember, 
      this.tglMasuk, 
      this.statusMasuk});

  Member.fromJson(Map<String, dynamic> json) {
    kdMember = json['kd_member'];
    password = json['password'];
    kdKendaraan = json['kd_kendaraan'];
    jurusan = json['jurusan'];
    kdKartu = json['kd_kartu'];
    namaMember = json['nama_member'];
    platMember = json['plat_member'];
    noRangkaMember = json['no_rangka_member'];
    noMesinMember = json['no_mesin_member'];
    createMember = json['create_member'];
    tglMasuk = json['tgl_masuk'];
    statusMasuk = json['status_masuk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kd_member'] = this.kdMember;
    data['password'] = this.password;
    data['kd_kendaraan'] = this.kdKendaraan;
    data['jurusan'] = this.jurusan;
    data['kd_kartu'] = this.kdKartu;
    data['nama_member'] = this.namaMember;
    data['plat_member'] = this.platMember;
    data['no_rangka_member'] = this.noRangkaMember;
    data['no_mesin_member'] = this.noMesinMember;
    data['create_member'] = this.createMember;
    data['tgl_masuk'] = this.tglMasuk;
    data['status_masuk'] = this.statusMasuk;

    return data;
  }
}