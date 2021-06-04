import 'package:flutter/material.dart';
import 'package:warung_app/Menu.dart';
import 'package:warung_app/main.dart';
import 'database.dart';

class AddMenuScreen extends StatefulWidget {
  @override
  _AddMenuScreenState createState() => _AddMenuScreenState();
}

class _AddMenuScreenState extends State<AddMenuScreen> {
  var dbHelper;

  final _menuForm = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final jumlahController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  addMenu(context) async {
    if (_menuForm.currentState.validate()) {
      final int harga = int.parse(hargaController.text);
      final int jumlah = int.parse(jumlahController.text);
      final newMenu =
          Menu(nama: namaController.text, harga: harga, jumlah: jumlah);

      print(namaController.text + ' - $harga - $jumlah');

      await dbHelper.addMenu(newMenu).then({
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text('Tambah Produk'),
          ),
          backgroundColor: Colors.teal[400],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(25),
              child: Form(
                key: _menuForm,
                child: Column(
                  children: [
                    TextFormField(
                      controller: namaController,
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
                        controller: hargaController,
                        decoration: InputDecoration(
                            labelText: 'Harga Produk',
                            hintText: 'Masukkan harga produk',
                            labelStyle: TextStyle(color: Colors.teal[400]),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.teal[400]))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Input harga produk.';
                          }
                          return null;
                        }),
                    TextFormField(
                      controller: jumlahController,
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
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Tambah'),
              onPressed: () => addMenu(context),
              style: ElevatedButton.styleFrom(primary: Colors.teal[400]),
            )
          ],
        )));
  }
}
