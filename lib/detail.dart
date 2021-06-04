import 'package:flutter/material.dart';
import 'package:warung_app/edit.dart';

class Detail extends StatefulWidget {
  final int id;
  final String nama;
  final int harga;
  final int jumlah;

  Detail({Key key, this.id, this.nama, this.harga, this.jumlah})
      : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  editMenu(id, nama, harga, jumlah) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Edit(
                  id: id,
                  nama: nama,
                  harga: harga,
                  jumlah: jumlah,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nama),
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 100),
          child: Column(
            children: [
              Center(child: Text('Nama Produk : ' + widget.nama.toString())),
              Center(child: Text('Harga : ' + widget.harga.toString())),
              Center(child: Text('Jumlah : ' + widget.jumlah.toString()))
            ],
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () =>
            editMenu(widget.id, widget.nama, widget.harga, widget.jumlah),
        backgroundColor: Colors.teal[400],
      ),
    );
  }
}
