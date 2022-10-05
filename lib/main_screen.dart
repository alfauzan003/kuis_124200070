import 'package:kuis/product_detail.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kuis/groceries.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final Groceries place = groceryList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProductDetail(productIdx: index);
              }));
            },
            child: Card(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      leading: Image.network(
                        place.productImageUrls[0],
                        width: 300,
                      ),
                      title: Text(place.name),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Harga :" + place.price),
                          Text("Diskon:" + place.discount),
                          Text("Nama toko:" + place.storeName),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                            onPressed: () async {
                              if (!await launch(place.productUrl))
                                throw 'Could not launch ${place.productUrl}';
                            },
                            child: const Text("Order"))
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        },
        itemCount: groceryList.length,
      ),
    );
  }
}
