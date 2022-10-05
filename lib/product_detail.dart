// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   final String username;
//   const HomePage({Key? key, required this.username}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   String _namaLengkap = "";
//   String _email = "";
//   String _noHp = "";
//   String _alamatRumah = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home Page"),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Center(
//               child: Text(
//                 "Hai ${widget.username}!\nSelamat Datang",
//                 textAlign: TextAlign.center,
//                 style: const TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30),
//               child: Center(
//                 child: Text(
//                   "Lengkapi Biodata",
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//               child: _buildForm(),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
//               child: _buildButtonSubmit(),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _formInput(
//       {required String hint,
//       required String label,
//       required Function(String value) setStateInput,
//       int maxLines = 1}) {
//     return TextFormField(
//       enabled: true,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hint,
//         label: Text(label),
//         contentPadding: EdgeInsets.all(12),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             borderSide: BorderSide(color: Colors.blue)),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             borderSide: BorderSide(color: Colors.orange)),
//       ),
//       onChanged: setStateInput,
//     );
//   }

//   Widget _buildForm() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: _formInput(
//               hint: "Masukkan Nama Lengkap",
//               label: "Nama *",
//               setStateInput: (value) {
//                 setState(() {
//                   _namaLengkap = value;
//                 });
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: _formInput(
//               hint: "Masukkan Alamat Email",
//               label: "Email *",
//               setStateInput: (value) {
//                 setState(() {
//                   _email = value;
//                 });
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: _formInput(
//               hint: "Masukkan No HP aktif",
//               label: "No HP *",
//               setStateInput: (value) {
//                 setState(() {
//                   _noHp = value;
//                 });
//               }),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           child: _formInput(
//               hint: "Masukkan Alamat Rumah",
//               label: "Alamat Rumah *",
//               setStateInput: (value) {
//                 setState(() {
//                   _alamatRumah = value;
//                 });
//               }),
//         ),
//       ],
//     );
//   }

//   Widget _buildButtonSubmit() {
//     return Container(
//       child: ElevatedButton(
//         onPressed: () {},
//         child: Text("Submit"),
//         style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.symmetric(horizontal: 32, vertical: 15),
//           textStyle: TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:kuis/main_screen.dart';
import 'package:kuis/groceries.dart';

class ProductDetail extends StatefulWidget {
  final int productIdx;

  const ProductDetail({Key? key, required this.productIdx}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  bool toggle = false;

  Widget build(BuildContext context) {
    final Groceries product = groceryList[widget.productIdx];
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon:
                    toggle ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
                onPressed: () {
                  setState(() {
                    toggle = !toggle;
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () async {
                    if (!await launch(product.productUrl))
                      throw 'Could not launch ${product.productUrl}';
                  }),
            )
          ],
        ),
        body: ListView(children: [
          Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Image.network(
                        product.productImageUrls[0],
                        width: 300,
                      ),
                    ),
                    Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Center(
                        child: Column(children: <Widget>[
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.blue,
                        ),
                        margin: EdgeInsets.all(20),
                        child: Table(
                          columnWidths: {
                            0: FlexColumnWidth(50),
                            1: FlexColumnWidth(300),
                          },
                          children: [
                            TableRow(children: [
                              Column(
                                children: [Text("Description")],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Column(
                                children: [Text(product.description)],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                children: [Text("Price")],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Column(
                                children: [Text("Rp" + product.price)],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                children: [Text("Stock")],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Column(
                                children: [Text(product.stock)],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                children: [Text("Discount")],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Column(
                                children: [Text(product.discount)],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                children: [Text("Store Name")],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Column(
                                children: [Text(product.storeName)],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ]),
                            TableRow(children: [
                              Column(
                                children: [Text("Review Average")],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              Column(
                                children: [Text(product.reviewAverage)],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ])),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
