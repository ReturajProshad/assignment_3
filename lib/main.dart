import 'package:flutter/material.dart';

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 20.0),
    Product(name: 'Product 3', price: 30.0),
    Product(name: 'Product 4', price: 15.0),
    Product(name: 'Product 5', price: 40.0),
    Product(name: 'Product 6', price: 50.0),
    Product(name: 'Product 7', price: 45.0),
    Product(name: 'Product 8', price: 55.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
            onBuyNow: () {
              setState(() {
                products[index].incrementCounter();
                if (products[index].counter == 5) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Congratulations!'),
                        content:
                            Text('You\'ve bought 5 ${products[index].name}!'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CartPage(products: products)),
          );
        },
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onBuyNow;

  ProductItem({required this.product, required this.onBuyNow});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: onBuyNow,
          ),
          Text("(${product.counter.toString()})"),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int counter;

  Product({required this.name, required this.price, this.counter = 0});

  void incrementCounter() {
    counter++;
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalProducts =
        products.fold(0, (sum, product) => sum + product.counter);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products: $totalProducts'),
      ),
    );
  }
}
