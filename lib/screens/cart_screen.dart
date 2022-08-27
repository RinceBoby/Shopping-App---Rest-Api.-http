import 'package:flutter/material.dart';
import 'package:rest_api/services/apiService.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ApiService().getCart('1'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List products = snapshot.data['products'];
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: ApiService()
                      .getSingleProduct(products[index]['productId']),
                  builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                    if (asyncSnapshot.hasData) {
                      return ListTile(
                        leading: Image.network(
                          asyncSnapshot.data['image'],
                          width: 100,
                          height: 100,
                        ),
                        title: Text(asyncSnapshot.data['title']),
                        subtitle:
                            Text("Quantity: ${products[index]['quantity']}"),
                        trailing: IconButton(
                          onPressed: () async {
                            await ApiService().removeFromCart("1");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Item Removed from Cart"),
                              ),
                              
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }
                    return const LinearProgressIndicator();
                  },
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: Colors.green,
        child: const Center(
          child: Text(
            "Order",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
