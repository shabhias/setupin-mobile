import 'package:flutter/material.dart';
import 'package:setupin/screens/item_list.dart';
import 'package:setupin/screens/menu.dart';
import 'package:setupin/screens/shoplist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                children: [
                  Text(
                    'Shopping List',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Text("Catat seluruh keperluan belanjamu di sini!",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                      // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa  (SUDAH)
                  ),
                ],
              ),
          ),

          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text('Tambah Item'),
              // Bagian redirection ke ShopFormPage
              onTap: () {
                /*
                TODO: Buatlah routing ke ShopFormPage di sini,
                setelah halaman ShopFormPage sudah dibuat. (SUDAH)
                */
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShopFormPage()),
              );

              },
          ),
          ListTile(
                leading: const Icon(Icons.checklist),
                title: const Text('Lihat Item'), // Menuju halaman daftar item
                onTap: () {
                  Navigator.pop(context); // Close the drawer if it's in the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemListPage()),
              );
             },
          ),

        ],
      ),
    );
  }
}