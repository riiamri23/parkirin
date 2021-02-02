class HistoryParkir {
  String kode;
  String tanggal;
  String kdMember;
  String namaMember;

  HistoryParkir({this.kode, this.tanggal, this.kdMember, this.namaMember});

  HistoryParkir.fromJson(Map<String, dynamic> json) {
    kode = json['kode'];
    tanggal = json['tanggal'];
    kdMember = json['kd_member'];
    namaMember = json['nama_member'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kode'] = this.kode;
    data['tanggal'] = this.tanggal;
    data['kd_member'] = this.kdMember;
    data['nama_member'] = this.namaMember;
    return data;
  }
}