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



