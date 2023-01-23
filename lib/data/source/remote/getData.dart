
class DataAPI{

  DataAPI({
    required this.data
  });

  late final List<Data> data;

  DataAPI.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }

}

class Data{

  Data({
    required this.nik,
    required this.nama,
    required this.umur,
    required this.kota,
  });
  
  late final String nik;
  late final String nama;
  late final int umur;
  late final String kota;

  Data.fromJson(Map<String, dynamic> json){
    nik = json['nik'];
    nama = json['nama'];
    umur = json['umur'];
    kota = json['kota'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nik']  = nik;
    _data['nama']  = nama;
    _data['umur']  = umur;
    _data['kota']  = kota;
    return _data;
  }

}