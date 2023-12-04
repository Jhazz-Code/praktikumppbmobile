import 'package:flutter/material.dart';

void main() => runApp(AppKulo());

class Product {
  final String nama;
  final String gambar;
  final double hargaasli;
  final double hargadiskon;
  final double rating;
  final int penjualan;
  final String deskripsi;

  Product(this.nama, this.gambar, this.hargaasli, this.hargadiskon, this.rating,
      this.penjualan, this.deskripsi);
}

enum ViewType { ListView, GridView }

class AppKulo extends StatefulWidget {
  @override
  _AppKuloState createState() => _AppKuloState();
}

class _AppKuloState extends State<AppKulo> {
  ViewType viewType = ViewType.ListView;

  final List<Product> products = [
    Product(
      "Assassin's Creed Origin",
      'assets/AC Origin.jpg',
      300.00,
      50.00,
      4.1,
      587,
      "Seri game Assassin's Creed yang menceritakan awal mula pembentukan ordo Hidden One",
    ),
    Product(
      "Assassin's Creed Revelation",
      'assets/AC Revelation.jpg',
      120.00,
      50.00,
      4.6,
      976,
      "Seri game Assassin's Creed dengan setting tempat kota Konstantinopel pada zaman pemerintahan kerajaan Ottoman.",
    ),
    Product(
      "Assassin's Creed Brotherhood",
      'assets/AC Brotherhood.jpg',
      70.00,
      20.00,
      4.2,
      786,
      "Seri game Assassin's Creed dengan setting tempat kota Roma pada zaman renaissance Italia.",
    ),
    Product(
      "Assassin's Creed Mirage",
      'assets/AC Mirage.jpg',
      680.00,
      500.00,
      4.7,
      189,
      "Seri game Assassin's Creed dengan setting tempat kota Baghdad pada periode Islamic Golden Age di zaman pemerintahan kekhalifahan Abbasiyah.",
    ),
  ];

  void toggleViewType() {
    setState(() {
      viewType =
          viewType == ViewType.ListView ? ViewType.GridView : ViewType.ListView;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('List Produk Game'),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(
              icon: Icon(
                  viewType == ViewType.ListView ? Icons.grid_view : Icons.list),
              onPressed: toggleViewType,
            ),
          ],
        ),
        body: viewType == ViewType.ListView
            ? ProductList(products: products)
            : ProductGrid(products: products),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(product: products[index]),
              ),
            );
          },
          child: ListTile(
            leading: Image.asset(products[index].gambar,
                width: isLandscape ? 200 : 100,
                height: isLandscape ? 200 : 100),
            title: Text(products[index].nama),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'Harga Asli: \Rp ${products[index].hargaasli.toStringAsFixed(2)}'),
                if (products[index].hargaasli != products[index].hargadiskon)
                  Text(
                      'Harga Diskon: \Rp ${products[index].hargadiskon.toStringAsFixed(2)}'),
                Row(
                  children: [
                    Text('Rating: ', style: TextStyle(fontSize: 16)),
                    for (int i = 0; i < 5; i++)
                      Icon(
                        Icons.star,
                        color: i < products[index].rating.round()
                            ? Colors.yellow
                            : Colors.grey,
                        size: isLandscape ? 30 : 20,
                      ),
                  ],
                ),
                Text('Penjualan: ${products[index].penjualan}'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 4 : 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetail(product: products[index]),
              ),
            );
          },
          child: Card(
            child: Column(
              children: <Widget>[
                Image.asset(products[index].gambar,
                    width: isLandscape ? 200 : 100,
                    height: isLandscape ? 200 : 100),
                Text(products[index].nama),
                if (products[index].hargaasli != products[index].hargadiskon)
                  Text(
                      'Harga Diskon: \Rp ${products[index].hargadiskon.toStringAsFixed(2)}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rating: ',
                      style: TextStyle(fontSize: isLandscape ? 24 : 18),
                    ),
                    for (int i = 0; i < 5; i++)
                      Icon(
                        Icons.star,
                        color: i < products[index].rating.round()
                            ? Colors.yellow
                            : Colors.grey,
                        size: isLandscape ? 36 : 24,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isLandscape ? 32 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(product.gambar,
                width: isLandscape ? 300 : 200,
                height: isLandscape ? 300 : 200),
            SizedBox(height: isLandscape ? 20 : 10),
            Text(product.nama,
                style: TextStyle(fontSize: isLandscape ? 32 : 24)),
            SizedBox(height: isLandscape ? 10 : 5),
            Text('Harga Asli: \Rp ${product.hargaasli.toStringAsFixed(2)}',
                style: TextStyle(fontSize: isLandscape ? 24 : 18)),
            if (product.hargaasli != product.hargadiskon)
              Text(
                'Harga Diskon: \Rp ${product.hargadiskon.toStringAsFixed(2)}',
                style: TextStyle(fontSize: isLandscape ? 24 : 18),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Rating: ',
                    style: TextStyle(fontSize: isLandscape ? 24 : 18)),
                for (int i = 0; i < 5; i++)
                  Icon(
                    Icons.star,
                    color: i < product.rating.round()
                        ? Colors.yellow
                        : Colors.grey,
                    size: isLandscape ? 36 : 24,
                  ),
              ],
            ),
            Text('Penjualan: ${product.penjualan}',
                style: TextStyle(fontSize: isLandscape ? 24 : 18)),
            SizedBox(height: isLandscape ? 20 : 10),
            Text('Deskripsi:',
                style: TextStyle(
                    fontSize: isLandscape ? 26 : 20,
                    fontWeight: FontWeight.bold)),
            Text(product.deskripsi,
                style: TextStyle(fontSize: isLandscape ? 22 : 16)),
            SizedBox(height: isLandscape ? 20 : 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Beli Game'),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
