# TUGAS 9

## Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?

- Ya, kita dapat melakukan pengambilan data JSON tanpa membuat model terlebih dahulu, dengan menggunakan dynamic dan menggunakan package 'dart:convert'

- Terdapat kekurangannya, yaitu ketidakpastian tipe data dan struktur yang kurang. Tetapi cocok untuk implementasi yang sederhana.



## Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.

- Fungsi dari cookieRequest adalah untuk mengirim permintaan HTTP yang menyertakan cookie. Ketika kita melakukan permintaan HTTP, server dapat mengirimkan cookie sebagai bagian dari responsnya. Cookie ini kemudian dapat disimpan oleh aplikasi dan dikirim kembali ke server dalam permintaan berikutnya.

- Instance CookieRequest perlu dibagikan ke semua komponen di aplikasi Flutter agar setiap komponen dapat menggunakan cookie yang sama saat melakukan permintaan HTTP. Dengan membagikan instance CookieRequest, kita dapat memastikan bahwa setiap komponen menggunakan cookie yang sama dan tidak ada konflik dalam penggunaan cookie di aplikasi.



## Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.

- kita perlu mengambil data dari web service yang menyediakan data dalam format JSON. Dalam flutter, menggunakan package http

- Setelah mendapatkan respons JSON dari web service, kita perlu mengolah data tersebut agar dapat digunakan dalam aplikasi Flutter. Kita dapat menggunakan package dart:convert untuk mengubah respons JSON menjadi objek Dart yang dapat digunakan dalam aplikasi.

- Setelah mengubah respons JSON menjadi objek Dart, kita dapat menggunakan objek tersebut untuk menampilkan data pada antarmuka pengguna (UI) Flutter. Kita dapat menggunakan widget seperti Text atau yang lainnya untuk menampilkan data dari objek Dart tersebut.



## Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
- Flutter mengirim permintaan autentikasi ke server Django menggunakan permintaan HTTP. Permintaan ini biasanya berisi data akun yang dimasukkan oleh pengguna.

-  Django menerima permintaan autentikasi dari Flutter dan memprosesnya. Django akan memeriksa data akun yang diberikan dan membandingkannya dengan data yang tersimpan dalam basis data. Jika data akun valid, Django akan menghasilkan token autentikasi yang akan digunakan untuk mengidentifikasi pengguna yang terautentikasi.

- Setelah pengguna terautentikasi, Flutter dapat mengirim permintaan ke server Django untuk mendapatkan data menu yang akan ditampilkan pada antarmuka pengguna (UI) Flutter. Permintaan ini biasanya menggunakan token autentikasi yang disertakan dalam header permintaan HTTP.

- jango memproses permintaan menu dari Flutter dan mengirimkan respons yang berisi data menu yang diminta. Respons ini biasanya dalam format JSON.

-  Flutter menerima respons menu dari Django dan menampilkan data menu tersebut




## Sebutkan seluruh widget yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.

- productPage widget: untuk mengambil data produk dari suatu URL.
- AppBar menampilkan judul "Product".
- LeftDrawer = menu navigasi 
- Container, Column, Test = utnuk menampilkan data product 



## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).


- Membuat halaman login pada proyek tugas Flutter dan Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
  1. Setup Autentikasi pada Django untuk Flutter
  membuat django-app bernama authentication. Kemudian menambhakan beberapa variable: 
  CORS_ALLOW_ALL_ORIGINS = True
  CORS_ALLOW_CREDENTIALS = True
  CSRF_COOKIE_SECURE = True
  SESSION_COOKIE_SECURE = True
  CSRF_COOKIE_SAMESITE = 'None'
  SESSION_COOKIE_SAMESITE = 'None'
  
  lalu membuat metode view untuk login 


  2. Integrasi Sistem Autentikasi pada Flutter

  menggunakan package provider dan  memodifikasi root widget buntuk menyediakan CookieRequest library ke semua child widgets dengan menggunakan Provider. Kemudian membuat file login.dart untuk membuat halaman loginnya
  

- Membuat model kustom sesuai dengan proyek aplikasi Django.
  menggunakan situs web Quicktype untuk mendapatkan kode model dari Json dan 



- Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.

MELAKUKAN FETCH DATA DARI DJANGO

'''
import 'package:<APP_NAME>/widgets/left_drawer.dart';

class ProductPage extends StatefulWidget {
    const ProductPage({Key? key}) : super(key: key);

    @override
    _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
Future<List<Product>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://<URL_APP_KAMU>/json/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Product> list_product = [];
    for (var d in data) {
        if (d != null) {
            list_product.add(Product.fromJson(d));
        }
    }
    return list_product;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Product'),
        ),
        drawer: const LeftDrawer(),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada data produk.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text("${snapshot.data![index].fields.price}"),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}")
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}








<br>
<hr>


# TUGAS 8

## Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement(), disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!

- Metode Navigator.push() digunakan untuk menambahkan halaman baru ke dalam tumpukan navigasi. Ketika menggunakan metode ini, halaman baru ditambahkan di atas halaman saat ini, dan pengguna dapat kembali ke halaman sebelumnya dengan menekan tombol kembali.

Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => HalamanBaru()),
);


- Metode Navigator.pushReplacement() digunakan untuk menggantikan halaman saat ini dengan halaman baru. Ketika menggunakan metode ini, halaman saat ini dihapus dari tumpukan navigasi dan digantikan dengan halaman baru. Ini berguna ketika Anda ingin mengganti halaman saat ini dengan halaman baru dan tidak ingin pengguna dapat kembali ke halaman sebelumnya.

Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => HalamanBaru()),
);

- perbedaan utama antara Navigator.push() dan Navigator.pushReplacement() adalah bahwa Navigator.push() menambahkan halaman baru ke dalam tumpukan navigasi, sementara Navigator.pushReplacement() menggantikan halaman saat ini dengan halaman baru.


## Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!

Element input yang saya gunakan adalah TextField, yaitu pada input name, amount, dan juga description. Penggunaan TextFormField sangat berguna dalam memberikan fleksibilitas untuk menerima berbagai jenis input. 

## Bagaimana penerapan clean architecture pada aplikasi Flutter?

Clean architecture merupakan pemisahan kode dengan beberapa file dengan memiliki tanggung jawab yang berbeda-beda. Sebelum menerapkan ini, kita harus mengetahui konsep MVVM (Model View ViewModel)Dengan memisahkan lapisan presentasi, lapisan domain, dan lapisan data, menjadi lebih mudah untuk memodifikasi dan memperluas kode tanpa menambahkan kompleksitas yang tidak perlu. 

1. Domain Layer:
    Entities: Representasi objek bisnis atau model domain yang independen dari infrastruktur.
    Use Cases (Interactors): Berisi logika bisnis (use cases) yang menggambarkan bagaimana data dan operasi terkait harus dijalankan.

2. Data Layer:
    Repositories: Abstraksi yang mendefinisikan cara mengakses dan menyimpan data. Repositori bertanggung jawab untuk berkomunikasi dengan data sources, seperti API, database lokal, atau cache.
    Data Sources: Mengimplementasikan akses konkret ke data, seperti remote API atau local database.

3. Presentation Layer:
    UI (User Interface): Menangani logika presentasi dan menampilkan data ke pengguna. Widget Flutter berada di lapisan ini.
    ViewModels atau Presenters: Menghubungkan antara Use Cases dari Domain Layer dengan UI. Merupakan penghubung antara UI dan logika bisnis.


## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step!

1. Membuat form yang memiliki tiga elemen input, yaitu name, amount, description dengan membuat file baru shoplist_form.dart. Pada file tersebut mengimplementasi halaman formulir Flutter (ShopFormPage) yang memungkinkan pengguna untuk memasukkan nama item, jumlah, dan deskripsi. Formulir ini menggunakan validasi untuk memastikan setiap elemen input tidak kosong dan sesuai dengan tipe datanya. Saat pengguna menekan tombol "Save," aplikasi akan menampilkan dialog konfirmasi dengan data yang diisi. Setelah pengguna menekan tombol "OK" pada dialog, item baru dibuat sebagai objek ShopDesc dan disimpan ke dalam list savedItems. Ini menerapkan pola Clean Architecture dengan memisahkan logika bisnis (mengenai penyimpanan item) dari tampilan dan mengikuti prinsip Flutter untuk pemisahan widget menjadi komponen yang terpisah.

2. Mengarahkan pengguna ke halaman form tambah item baru ketika menekan tombol Tambah Item pada halaman utama.

'''
    if (item.name == "Tambah Item") {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShopFormPage()),
    );
    }

Gunakan Navigator.push untuk melakukan navigasi ke MaterialPageRoute yang mencakup ShopFormPage

3. Memunculkan data sesuai isi dari formulir yang diisi dalam sebuah pop-up setelah menekan tombol Save pada halaman formulir tambah item baru

'''
                onPressed: () 
                if (_formKey.currentState!.validate()) 
                  showDialog
                        context: context,
                        builder: (context) 
                          return AlertDialog
                            title: const Text('Item berhasil tersimpan'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('Nama: $_name'),
                                  Text('Amount: $_amount'),
                                  Text('Deskripsi: $_description'),
                                
                                ],
                              ),
                            ),
                            actions: 
                              TextButton
                                child: const Text('OK'),
                                onPressed: () 
                                  Navigator.pop(context);


## Membuat sebuah drawer pada aplikasi 

1. Membuat left_drawer.dart

2. 

'''
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

Kode tersebut mendefinisikan tiga ListTile dalam sebuah drawer pada aplikasi Flutter. Pertama, ListTile dengan ikon rumah (home_outlined) dan teks "Halaman Utama" akan mengarahkan pengguna kembali ke halaman utama (MyHomePage) saat ditekan. Kedua, ListTile dengan ikon keranjang belanja (add_shopping_cart) dan teks "Tambah Item" akan mengarahkan pengguna ke halaman formulir tambah item (ShopFormPage) saat ditekan. Terakhir, ListTile dengan ikon checklist (checklist) dan teks "Lihat Item" akan menutup drawer (jika terbuka) dan mengarahkan pengguna ke halaman daftar item (ItemListPage). Dengan menggunakan Navigator.push dan MaterialPageRoute, aplikasi dapat melakukan navigasi antar-halaman dengan responsif.



## BONUS

1. membuat class ShopDesc yang didalamnya ada list, untuk menampung item yang sudah di save dengan field nama, amount, dan description. 
2. Kemudian menambahkan left drawer untuk lihat Item 
''' 
          ListTile(
                title: const Text('Lihat Item'), // Menuju halaman daftar item
                onTap: () {
                  Navigator.pop(context); // Close the drawer if it's in the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ItemListPage()),
              );
             },
          ),
3. Menambahkan item yang sudah di save di form 
'''
          setState(() {
            ShopDesc newItem = ShopDesc(
              name: _name,
              amount: _amount,
              description: _description,
            );

            // Menyimpan item ke dalam list savedItems
            newItem.saveItem();
            });

4. Membuat file item_list.dart untuk menampilkan list item yang sudah disimpan
'''
          class ItemListPage extends StatelessWidget {
            @override
            Widget build(BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Daftar Item'),
                ),
                body: ShopDesc.savedItems.isEmpty
                    ? Center(child: const Text('Belum ada item yang dibuat'))
                    : ListView.builder(
                        itemCount: ShopDesc.savedItems.length,
                        itemBuilder: (context, index) {
                          ShopDesc item = ShopDesc.savedItems[index];
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text('Amount: ${item.amount} | Deskripsi: ${item.description}'),
                          );
                        },
                      ),
              );
            }
          }

<br>
<hr>










# TUGAS 7

## Apa perbedaan utama antara stateless dan stateful widget dalam konteks pengembangan aplikasi Flutter?

- Stateless Widget adalah jenis widget yang tidak memiliki keadaan (state) yang berubah. Artinya, setelah widget ini dibangun, tampilannya tidak akan berubah kecuali ada perubahan pada properti yang diberikan ke widget tersebut. Stateless Widget biasanya digunakan untuk bagian-bagian aplikasi yang tidak memerlukan perubahan tampilan berdasarkan interaksi pengguna atau perubahan data.

- Stateful Widget adalah jenis widget yang memiliki keadaan (state) yang dapat berubah. Widget ini dapat memperbarui tampilannya ketika ada perubahan pada keadaan (state) yang dimilikinya. Stateful Widget biasanya digunakan untuk bagian-bagian aplikasi yang memerlukan perubahan tampilan berdasarkan interaksi pengguna atau perubahan data, seperti formulir, daftar item yang dapat di-scroll, dan lain sebagainya

## Sebutkan seluruh widget yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.

- MyApp (StatelessWidget):
Merupakan widget utama yang mewakili aplikasi. Ini adalah widget yang digunakan sebagai root dari aplikasi Anda. Ini menginisialisasi MaterialApp dan menentukan tema aplikasi.

- MyHomePage (StatelessWidget):
Merupakan widget yang mewakili halaman utama aplikasi. Ini berisi tampilan utama yang akan ditampilkan kepada pengguna

- ShopCard (StatelessWidget):
Ini adalah widget yang digunakan untuk menampilkan kartu untuk setiap item toko. Menerima objek ShopItem sebagai argumen.

- Icon, text (Widget)
untuk menampilkan ikon dan teks yang sesuai 

- AppBar (Widget):
Ini adalah App Bar yang menampilkan judul "Shopping List" di bagian atas halaman.


## Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step (bukan hanya sekadar mengikuti tutorial)

1. Saya mengenerate proyek Flutter baru dengan nama setupin: flutter create setupin

Di dalam direktori tersebut, Flutter akan membuat struktur proyek Flutter standar, termasuk file-file dan direktori yang diperlukan untuk membangun aplikasi Flutter. Struktur proyek ini termasuk direktori lib untuk kode Dart aplikasi, test untuk tes, android untuk proyek Android, ios untuk proyek iOS, dan sejumlah file konfigurasi

2. menjalankan flutter config --enable-web untuk enable web support

3. mengubah sifat widget halaman dari stateful menjadi stateless
    
class MyHomePage extends StatelessWidget 
  MyHomePage({Key? key}) : super(key: key);


4. Membuat widget sederhana pada flutter dengan mendefinisikan tipe pada list. 

class ShopItem {
  final String name;
  final IconData icon;

  ShopItem(this.name, this.icon);
}

5. kemudian menambahkan barang-barang yang dijual (nama, harga, dan icon barang tersebut).

final List<ShopItem> items = [
    ShopItem("Lihat Produk", Icons.checklist),
    ShopItem("Tambah Produk", Icons.add_shopping_cart),
    ShopItem("Logout", Icons.logout),
];

6. untuk menggambarkan tampilan halaman utama (home page) dari aplikasi 

return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping List',
        ),
      ),
      body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
          padding: const EdgeInsets.all(10.0), // Set padding dari halaman
          child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                  'PBP Shop', // Text yang menandakan toko
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Grid layout
              GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ShopItem item) {
                  // Iterasi untuk setiap item
                  return ShopCard(item);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );


7. untuk membuat widget stateless baru untuk menampilkan card yang sudah di definiskan sebelumnya

Widget build(BuildContext context) 
    return Material(
      color: Colors.indigo,
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );

## BONUS

Untuk bonus, saya menambahkan atribut color pada class ShopItem. Agar setiap item memiliki warna yang berbeda-beda

class ShopItem {
  final String name;
  final IconData icon;
  final Color color;

  ShopItem(this.name, this.icon, this.color);
}

dan menerapkan pada list shop item

final List<ShopItem> items = [
  ShopItem("Lihat Item", Icons.checklist, Colors.blue),
  ShopItem("Tambah Item", Icons.add_shopping_cart, Colors.green),
  ShopItem("Logout", Icons.logout, Colors.red),
];

dan menggantikan 
Widget build(BuildContext context) 
    return Material
      color: item.color, ---> color menjadi item.color yang bisa ditentukkan warna sesuai pada itemnya

<br>
<hr>




















































# setupin

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



