class DataContacts{

  DataContacts({required this.nik,
    required this.nama,
    required this.umur,
    required this.kota,
  });
  
  late final int nik;
  late final String nama;
  late final int umur;
  late final String kota;

  factory DataContacts.fromMap(Map<String, dynamic> json) => new DataContacts(
    nik : json['nik'],
    nama : json['nama'],
    umur : json['umur'],
    kota : json['kota'],
  );

  Map<String, dynamic> toMap() {
    return{
      'nik' : this.nik,
      'nama' : this.nama,
      'umur' : this.umur,
      'kota' : this.kota,
    };
  }

}