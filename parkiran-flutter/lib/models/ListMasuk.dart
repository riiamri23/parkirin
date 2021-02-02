class ListMasuk {
  String kdMasuk;
  String kdMember;
  String kdKendaraan;
  String platMasuk;
  String tglMasuk;
  String statusMasuk;
  String createMasuk;
  String namaKendaraan;
  String hargaKendaraan;
  String jenisKendaraan;
  String createByKendaraan;

  ListMasuk(
      {this.kdMasuk,
      this.kdMember,
      this.kdKendaraan,
      this.platMasuk,
      this.tglMasuk,
      this.statusMasuk,
      this.createMasuk,
      this.namaKendaraan,
      this.hargaKendaraan,
      this.jenisKendaraan,
      this.createByKendaraan});

  ListMasuk.fromJson(Map<String, dynamic> json) {
    kdMasuk = json['kd_masuk'];
    kdMember = json['kd_member'];
    kdKendaraan = json['kd_kendaraan'];
    platMasuk = json['plat_masuk'];
    tglMasuk = json['tgl_masuk'];
    statusMasuk = json['status_masuk'];
    createMasuk = json['create_masuk'];
    namaKendaraan = json['nama_kendaraan'];
    hargaKendaraan = json['harga_kendaraan'];
    jenisKendaraan = json['jenis_kendaraan'];
    createByKendaraan = json['create_by_kendaraan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kd_masuk'] = this.kdMasuk;
    data['kd_member'] = this.kdMember;
    data['kd_kendaraan'] = this.kdKendaraan;
    data['plat_masuk'] = this.platMasuk;
    data['tgl_masuk'] = this.tglMasuk;
    data['status_masuk'] = this.statusMasuk;
    data['create_masuk'] = this.createMasuk;
    data['nama_kendaraan'] = this.namaKendaraan;
    data['harga_kendaraan'] = this.hargaKendaraan;
    data['jenis_kendaraan'] = this.jenisKendaraan;
    data['create_by_kendaraan'] = this.createByKendaraan;
    return data;
  }
}