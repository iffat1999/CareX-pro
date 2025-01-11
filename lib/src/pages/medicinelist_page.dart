import 'package:carex_pro/src/pages/cart/cart_view.dart';
import 'package:flutter/material.dart';

class MedicineListPage extends StatefulWidget {
  const MedicineListPage({super.key});

  @override
  State<MedicineListPage> createState() => _MedicineListPageState();
}

class _MedicineListPageState extends State<MedicineListPage> {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Paracetamol 500mg",
      "price": 5.0,
      "image": "assets/images/paracetamol.png",
    },
    {
      "name": "Vitamin C Tablets",
      "price": 10.0,
      "image": "assets/images/medicines/vitamin_c.jpg",
    },
    {
      "name": "Thermometer",
      "price": 25.0,
      "image": "assets/images/medicines/thermometer.jpeg",
    },
    {
      "name": "Antiseptic Cream",
      "price": 8.0,
      "image": "assets/images/medicines/antiseptic.jpeg",
    },
  ];

  final List<Map<String, dynamic>> cart = [];
  String searchQuery = "";

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
  }

  void goToCartPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartView(cart: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products
        .where((product) =>
            product["name"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Medicine",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green.shade400,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.green.shade400, // Background color
          borderRadius: BorderRadius.circular(16), // Rounded rectangle
        ),
        padding: const EdgeInsets.all(8), // Padding around the icon
        child: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: goToCartPage,
          color: Colors.white, // Icon color
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Image.asset(
                      product["image"]!,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(
                      product["name"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "\$${product["price"].toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart),
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Added to cart!"),
                          duration: Duration(seconds: 1),
                        ));
                        addToCart(product);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
