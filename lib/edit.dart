import 'package:flutter/material.dart';
import 'package:warung_app/database.dart';
import 'package:warung_app/Menu.dart';
import 'package:warung_app/main.dart';

class Edit extends StatefulWidget {
  final int id;
  final String nama;
  final int harga;
  final int jumlah;

  Edit({Key key, this.id, this.nama, this.harga, this.jumlah})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  var dbHelper;

  final _editForm = GlobalKey<FormState>();

  final editNamaController = TextEditingController();
  final editHargaController = TextEditingController();
  final editJumlahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    getDataToUpdate();
  }

  getDataToUpdate() {
    editNamaController.text = widget.nama;
    editHargaController.text = widget.harga.toString();
    editJumlahController.text = widget.jumlah.toString();
  }

  updateMenu(context) async {
    if (_editForm.currentState.validate()) {
      final newMenu = Menu(
        id: widget.id,
        nama: editNamaController.text,
        harga: int.parse(editHargaController.text),
        jumlah: int.parse(editJumlahController.text),
      );

      await dbHelper.updateMenu(newMenu).then({
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    selectedIndex: 0,
                  )),
          (Route<dynamic> route) => false,
        )
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Produk'),
          backgroundColor: Colors.teal[400],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Form(
                key: _editForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: editNamaController,
                      decoration: InputDecoration(
                          labelText: 'Nama Produk',
                          hintText: 'Masukkan nama produk',
                          labelStyle: TextStyle(color: Colors.teal[400]),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[400]))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input nama produk.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: editHargaController,
                      decoration: InputDecoration(
                          labelText: 'Harga Produk',
                          hintText: 'Masukkan harga produk',
                          labelStyle: TextStyle(color: Colors.teal[400]),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[400]))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input nama produk.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: editJumlahController,
                      decoration: InputDecoration(
                          labelText: 'Jumlah Produk',
                          hintText: 'Masukkan jumlah produk',
                          labelStyle: TextStyle(color: Colors.teal[400]),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[400]))),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Input jumlah produk.';
                        }
                        return null;
                      },
                    )
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Update'),
              onPressed: () => updateMenu(context),
              style: ElevatedButton.styleFrom(primary: Colors.teal[400]),
            )
          ],
        )));
  }
}
