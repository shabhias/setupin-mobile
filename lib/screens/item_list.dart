import 'package:flutter/material.dart';
import 'package:setupin/widgets/shop_card.dart';


// class ItemListPage extends StatefulWidget {
//   final List<ShopDesc> itemList;

//   const ItemListPage(itemList, {required this.itemList});

//   @override
//   State<ItemListPage> createState() => _ItemListPageState();
// }

// class _ItemListPageState extends State<ItemListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daftar Item'),
//       ),
//       body: widget.itemList.isEmpty
//           ? Center(child: const Text('Belum ada item yang dibuat'))
//           : ListView.builder(
//               itemCount: widget.itemList.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(widget.itemList[index].name),
//                   subtitle: Text(
//                       'Amount: ${widget.itemList[index].amount} | Deskripsi: ${widget.itemList[index].description}'),
//                 );
//               },
//             ),
//     );
//   }
// }


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



