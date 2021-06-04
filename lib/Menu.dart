class Menu {
  final int id;
  final String nama;
  final int jumlah;
  final int harga;

  Menu({this.id, this.nama, this.jumlah, this.harga});

  Map<String, dynamic> toMap() {
    return {'id': id, 'nama': nama, 'jumlah': jumlah, 'harga': harga};
  }

  @override
  String toString() {
    return 'Menu {id:$id, nama:$nama, jumlah:$jumlah, harga:$harga}';
  }
}
