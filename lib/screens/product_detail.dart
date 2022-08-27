import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rest_api/services/apiService.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({required this.id, Key? key}) : super(key: key);
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(CupertinoIcons.arrow_left)),
      ),
      body: FutureBuilder(
        future: ApiService().getSingleProduct(id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.network(
                    snapshot.data['image'],
                    height: 200,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Price: \$ ${snapshot.data['price'].toString()}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    snapshot.data['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Chip(
                    label: Text(
                      snapshot.data['category'].toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    snapshot.data['description'],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ApiService().updateCart("1", "id");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Product Added to Cart"),
            ),
          );
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(CupertinoIcons.cart_badge_plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
