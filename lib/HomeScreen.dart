import 'package:flutter/material.dart';
import 'package:warung_app/Menu.dart';
import 'package:warung_app/database.dart';
import 'package:warung_app/main.dart';
import 'package:warung_app/detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Menu>> menu;
  var dbhelper;

  @override
  void initState() {
    super.initState();
    dbhelper = DbHelper();
    loadMenu();
  }

  loadMenu() {
    setState(() {
      menu = dbhelper.getMenu();
    });
  }

  detailMenu(context, currentItem) {
    print(currentItem);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Detail(
                id: currentItem.id,
                nama: currentItem.nama,
                harga: currentItem.harga,
                jumlah: currentItem.jumlah)));
  }

  removeMenu(menuId) {
    dbhelper.deleteMenu(menuId);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                selectedIndex: 0,
              )),
      (Route<dynamic> route) => false,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('List Produk'),
          ),
          backgroundColor: Colors.teal[400],
        ),
        body: FutureBuilder(
            future: menu,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // success
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text('List produk masih kosong.'),
                  );
                }
                return Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final currentItem = snapshot.data[index];
                        return Container(
                          child: Card(
                            child: ListTile(
                              title: Text('${currentItem.nama}'),
                              // onTap: () => updateMenu(context, currentItem),
                              trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () => removeMenu(currentItem.id)),
                              onTap: () => detailMenu(context, currentItem),
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                //error
                return Center(child: Text('Error fetching data'));
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.teal[400]),
                ));
              }
            }));
  }
}
